import UIKit

class DetailsView: UIView { 
    private var content: DetailsViewController.ViewContent?
    
    // MARK: - Private Properties
    private let scrollView = CustomScrollView()
    
    // MARK: - DetailsView initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSubviewsAndLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(content: DetailsViewController.ViewContent) {
        self.content = content
        scrollView.content = content.item
    }
}

// MARK: - Private methods
extension DetailsView {
    private func setSubviewsAndLayout() {
        // Adding subviews to DetailsView
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
