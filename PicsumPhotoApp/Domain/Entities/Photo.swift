import Foundation

struct Photo {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let downloadUrl: String
    
    var aspectRatio: Double {
        guard height > 0 else { return 0.6 }
        return Double(width) / Double(height)
    }
}
