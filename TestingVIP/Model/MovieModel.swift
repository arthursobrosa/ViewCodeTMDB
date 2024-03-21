import UIKit

struct MovieModel: Codable {
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Double
    let posterPath: String
    
    var imageData: Data?
    
    var genresArray: [String]?
    
    func ratingsFormatted() -> String {
        return "☆ " + String(format: "%.1f", voteAverage)
    }
    
    func imageConverted() -> UIImage {
        if let imageData = imageData, let image = UIImage(data: imageData) {
            return image
        } else {
            return UIImage(named: "defaultImage")!
        }
    }
    
    func genresFormatted() -> String {
        guard let genresArray = genresArray else { return String() }
        
        var genresText = String()
        for i in 0..<genresArray.count {
            if i == genresArray.count - 1 {
                genresText += genresArray[i]
            } else {
                genresText += genresArray[i] + ", "
            }
        }
        
        return genresText
    }
}

struct MovieResponse: Codable {
    let results: [MovieModel]
}

struct Genre: Codable {
    let name: String
}

struct GenreResponse: Codable {
    let genres: [Genre]
}
