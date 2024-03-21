import UIKit

protocol MoviesInteractorProtocol {
    func loadMovies()
    func didSelect(indexPath: IndexPath)
}

final class MoviesInteractor {
    private let presenter: MoviesPresenterProtocol?
    
    private var popularMovies: [MovieModel] = []
    private var nowPlayingMovies: [MovieModel] = []
    
    init(presenter: MoviesPresenterProtocol?) {
        self.presenter = presenter
    }
}

// MARK: - Movies Interactor Protocol
extension MoviesInteractor: MoviesInteractorProtocol {
    func loadMovies() {
        Task {
            do {
                popularMovies = try await MovieService.shared.fetchMovies(for: .popular)
                presenter?.showData(movies: popularMovies, of: .popular)
                
                nowPlayingMovies = try await MovieService.shared.fetchMovies(for: .nowPlaying)
                presenter?.showData(movies: nowPlayingMovies, of: .nowPlaying)
            } catch {
                print(error)
            }
        }
    }
    
    func didSelect(indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        let movie = section == 0 ? popularMovies[row] : nowPlayingMovies[row]
        
        presenter?.showDetails(movie: movie)
    }
}
