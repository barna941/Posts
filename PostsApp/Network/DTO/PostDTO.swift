import Foundation

struct PostDTO: Codable {
    let text: String
    let image: String
    let likes: Int
    let link: String?
    let tags: [String]
    let publishDate: String
}
