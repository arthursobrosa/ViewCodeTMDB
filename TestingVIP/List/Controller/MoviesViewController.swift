import UIKit

protocol MoviesViewControllerProtocol: AnyObject {
    func showData(content: MoviesViewController.ViewContent)
    func showViewController(viewController: UIViewController)
}

class MoviesViewController: UIViewController {
    struct ViewContent {
        var items: [MovieCell.MovieCellContent]
        var sectionType: SectionType
    }
    
    var interactor: MoviesInteractorProtocol?
    
    // MARK: - Private properties
    private lazy var moviesView: MoviesView = {
        let moviesView = MoviesView()
        moviesView.delegate = self
        
        return moviesView
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "TMDB"
        
        interactor?.loadMovies()
    }
    
    override func loadView() {
        super.loadView()
        
        view = moviesView
    }
}

// MARK: - Movies View Controller Protocol
extension MoviesViewController: MoviesViewControllerProtocol {
    func showData(content: ViewContent) {
        moviesView.setContent(content: content)
    }
    
    func showViewController(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Movies View Protocol
extension MoviesViewController: MoviesViewProtocol {
    func didSelect(indexPath: IndexPath) {
        interactor?.didSelect(indexPath: indexPath)
    }
}



