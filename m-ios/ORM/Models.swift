import Foundation

struct Universities: Decodable, Identifiable {
    let id: String
    let name: String
    let slug: String
    let createdAt: Date
    let updatedAt: Date
}

struct FoodDeals: Decodable, Identifiable {
    let id: String
    let title: String
    let place: String
    let timeStart: Date
    let timeEnd: Date
    let priceStart: Decimal?
    let priceEnd: Decimal?
    let description: String?
    let reports: Int
    let universityId: String
    let createdAt: Date
}

