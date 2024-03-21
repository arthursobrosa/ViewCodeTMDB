import UIKit

class MovieService {
    static let shared = MovieService()
    
    private let baseURL = "https://api.themoviedb.org/3/movie/"
    private let endpoint = "?api_key=c35195914030e073d91b56ed558d898e"
    
    private let baseImageURL = "https://image.tmdb.org/t/p/w500/"
    
    
    public func fetchMovies(for sectionType: SectionType) async throws -> [MovieModel] {
        var movies: [MovieModel] = []
        let sectionName = sectionType.rawValue
        
        guard let url = URL(string: baseURL + sectionName + endpoint) else {
            throw MovieError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MovieError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedData = try decoder.decode(MovieResponse.self, from: data)
            movies = decodedData.results
        } catch {
            throw MovieError.invalidData
        }
        
        for i in 0..<movies.count {
            movies[i].imageData = try await fetchImage(with: movies[i].posterPath)
            movies[i].genresArray = try await fetchGenres(movies[i].id)
        }
        
        return movies
    }
    
    private func fetchImage(with posterPath: String) async throws -> Data {
        guard let url = URL(string: baseImageURL + posterPath) else { throw MovieError.invalidImageURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MovieError.invalidImageResponse
        }
        
        return data
    }
    
    private func fetchGenres(_ movieID: Int) async throws -> [String] {
        let urlString = baseURL + String(movieID) + endpoint
        
        guard let url = URL(string: urlString) else { throw MovieError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MovieError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedData = try decoder.decode(GenreResponse.self, from: data)
            let genres = decodedData.genres
            let genresArray = genres.compactMap { $0.name }
            return genresArray
        } catch {
            throw MovieError.invalidData
        }
    }
}

enum MovieError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
    case invalidImageURL
    case invalidImageResponse
}

enum SectionType: String, CaseIterable {
    case popular
    case nowPlaying = "now_playing"
    
    var title: String {
        switch self {
            case .popular:
                return "Popular"
            case .nowPlaying:
                return "Now Playing"
        }
    }
}
