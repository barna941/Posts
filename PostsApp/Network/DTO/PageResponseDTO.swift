import Foundation

struct PageResponseDTO<T: Codable>: Codable {
    let data: [T]
    let total: Int
    let page: Int
    let limit: Int
    let offset: Int
}
