
import Foundation

struct MoviesData : Codable {
	let results : [MoviesResults]?
    
	enum CodingKeys: String, CodingKey {
        case results = "results"
	}
}

struct MoviesResults : Codable {
    let id : Int?
    let overview : String?
    let popularity : Double?
    let poster_path : String?
    let title : String?
    let name : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case overview = "overview"
        case popularity = "popularity"
        case poster_path = "poster_path"
        case title = "title"
        case name = "name"
    }
}
