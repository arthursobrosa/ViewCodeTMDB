import UIKit

class CustomScrollView: UIScrollView {
    struct ScrollViewContent {
        var movie: MovieModel?
    }
    
    var content: ScrollViewContent? {
        didSet {
            guard let movie = content?.movie else { return }
            movieImage.image = movie.imageConverted()
            titleLabel.text = movie.title
            genresLabel.text = movie.genresFormatted()
            ratingsLabel.text = movie.ratingsFormatted()
            overviewTitle.text = "Overview"
            overviewLabel.text = movie.overview
        }
    }
    
    // MARK: - Private properties
    private let contentView: UIView = {
        let contentView = UIView()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private let topView: UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        return topView
    }()
    
    private let movieImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    private let titleLabel = CustomLabel(frame: .zero, sentFont: .boldSystemFont(ofSize: 20), sentColor: .label)
    private let genresLabel = CustomLabel(frame: .zero, sentFont:  .systemFont(ofSize: 16), sentColor: .systemGray3)
    private let ratingsLabel = CustomLabel(frame: .zero, sentFont: .systemFont(ofSize: 12), sentColor: .systemGray3)
    
    private let bottomView: UIView = {
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        return bottomView
    }()
    
    private let overviewTitle = CustomLabel(frame: .zero, sentFont: .boldSystemFont(ofSize: 14), sentColor: .label)
    private let overviewLabel = CustomLabel(frame: .zero, sentFont: .systemFont(ofSize: 14), sentColor: .systemGray)
    
    // MARK: - CustomScrollView initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSubviewsAndLayout()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isDirectionalLockEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods
extension CustomScrollView {
    private func setSubviewsAndLayout() {
        // Adding subviews to contentView
        contentView.addSubview(movieImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(ratingsLabel)
        contentView.addSubview(overviewTitle)
        contentView.addSubview(overviewLabel)
        
        // Adding contentView to CustomScrollView
        addSubview(contentView)
        
        // Setting layout
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            contentView.bottomAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: -20),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
            
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.24),
            movieImage.widthAnchor.constraint(equalTo: movieImage.heightAnchor, multiplier: 0.66),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: movieImage.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            genresLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            genresLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            genresLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            ratingsLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 10),
            ratingsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingsLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            overviewTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 16),
            overviewTitle.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor),
            overviewTitle.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            overviewLabel.topAnchor.constraint(equalTo: overviewTitle.bottomAnchor, constant: 10),
            overviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            overviewLabel.leadingAnchor.constraint(equalTo: overviewTitle.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: overviewTitle.trailingAnchor),
        ])
    }
}
