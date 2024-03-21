import UIKit

class CustomLabel: UILabel {
    var sentFont: UIFont?
    var sentColor: UIColor?
    
    init(frame: CGRect, sentFont: UIFont?, sentColor: UIColor?) {
        super.init(frame: frame)
        
        self.sentFont = sentFont
        self.sentColor = sentColor
        
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        self.textAlignment = .left
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        
        self.font = sentFont
        self.textColor = sentColor
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
