import Foundation

struct Universities: Decodable, Identifiable {
    let id: String
    let name: String
    let slug: String
    let createdAt: Date
    let updatedAt: Date
}

