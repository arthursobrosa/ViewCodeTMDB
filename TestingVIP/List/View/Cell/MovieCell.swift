import UIKit

class MovieCell: UITableViewCell {
    struct MovieCellContent {
        var movie: MovieModel?
    }
    
    var content: MovieCellContent? {
        didSet {
            guard let movie = content?.movie else { return }
            
            coverImage.image = movie.imageConverted()
            movieTitleLabel.text = movie.title
            overviewLabel.text = movie.overview
            ratingsLabel.text = movie.ratingsFormatted()
        }
    }
    
    private let coverImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    private let labelsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = .systemGray
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let ratingsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .left
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setSubviewsAndLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieCell {
    private func setSubviewsAndLayout() {
        contentView.addSubview(coverImage)
        contentView.addSubview(labelsView)
        
        labelsView.addSubview(movieTitleLabel)
        labelsView.addSubview(overviewLabel)
        labelsView.addSubview(ratingsLabel)
        
        NSLayoutConstraint.activate([
            coverImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coverImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            coverImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -16),
            coverImage.widthAnchor.constraint(equalTo: coverImage.heightAnchor, multiplier: 0.666),
            
            labelsView.centerYAnchor.constraint(equalTo: coverImage.centerYAnchor),
            labelsView.leadingAnchor.constraint(equalTo: coverImage.trailingAnchor, constant: 10),
            labelsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            labelsView.heightAnchor.constraint(equalTo: coverImage.heightAnchor, constant: -20),
            
            movieTitleLabel.topAnchor.constraint(equalTo: labelsView.topAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: labelsView.leadingAnchor),
            movieTitleLabel.trailingAnchor.constraint(equalTo: labelsView.trailingAnchor),
            
            overviewLabel.centerYAnchor.constraint(equalTo: labelsView.centerYAnchor),
            overviewLabel.leadingAnchor.constraint(equalTo: labelsView.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: labelsView.trailingAnchor),
            
            ratingsLabel.bottomAnchor.constraint(equalTo: labelsView.bottomAnchor),
            ratingsLabel.leadingAnchor.constraint(equalTo: labelsView.leadingAnchor),
            ratingsLabel.trailingAnchor.constraint(equalTo: labelsView.trailingAnchor)
        ])
    }
}
