import UIKit

struct MoviesFactory {
    static func build() -> UIViewController {
        let view = MoviesViewController()
        let presenter = MoviesPresenter(view: view)
        let interactor = MoviesInteractor(presenter: presenter)
        
        view.interactor = interactor
        
        return view
    }
}
