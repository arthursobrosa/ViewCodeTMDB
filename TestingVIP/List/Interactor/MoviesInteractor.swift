import UIKit

protocol MoviesInteractorProtocol {
    func loadMovies()
    func didSelect(indexPath: IndexPath)
}

final class MoviesInteractor {
    private let presenter: MoviesPresenterProtocol?
    
    private var movies: [MovieModel] = []
    
    init(presenter: MoviesPresenterProtocol?) {
        self.presenter = presenter
    }
}

// MARK: - Movies Interactor Protocol
extension MoviesInteractor: MoviesInteractorProtocol {
    func loadMovies() {
        let allSectionTypes = SectionType.allCases
        
        for sectionType in allSectionTypes {
            Task {
                do {
                    movies = try await MovieService.shared.fetchMovies(for: sectionType)
                    presenter?.showData(movies: movies, of: sectionType)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func didSelect(indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        presenter?.showDetails(movie: movie)
    }
}
