import Foundation

struct PhotoDTO: Decodable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let download_url: String
    
    func toDomain() -> Photo {
        return Photo(
            id: id,
            author: author,
            width: width,
            height: height,
            downloadUrl: download_url
        )
    }
}