import UIKit

class DetailsViewController: UIViewController {
    struct ViewContent {
        var item: CustomScrollView.ScrollViewContent
    }
    
    var content: ViewContent?
    private var detailsView = DetailsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        if let content = content {
            detailsView.setContent(content: content)
        }
    }
    
    override func loadView() {
        self.view = detailsView
    }
}
