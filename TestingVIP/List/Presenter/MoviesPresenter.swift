import UIKit

protocol MoviesPresenterProtocol: AnyObject {
    func showDetails(movie: MovieModel)
    func showData(movies: [MovieModel], of sectionType: SectionType)
}

final class MoviesPresenter {
    private weak var view: MoviesViewControllerProtocol?
    
    init(view: MoviesViewControllerProtocol?) {
        self.view = view
    }
}

// MARK: - Movies Presenter Protocol
extension MoviesPresenter: MoviesPresenterProtocol {
    func showDetails(movie: MovieModel) {
        let detailsVC = DetailsViewController()
        detailsVC.content = .init(item: .init(movie: movie))
        detailsVC.title = "Details"
        
        view?.showViewController(viewController: detailsVC)
    }
    
    func showData(movies: [MovieModel], of sectionType: SectionType) {
        var items: [MovieCell.MovieCellContent] = []
        
        for i in 0..<movies.count {
            let movieCellContent = MovieCell.MovieCellContent.init(movie: movies[i])
            items.append(movieCellContent)
        }
        
        view?.showData(content: .init(movies: items, sectionType: sectionType))
    }
}
