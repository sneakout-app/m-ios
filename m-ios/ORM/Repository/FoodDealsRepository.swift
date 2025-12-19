import Foundation
import Supabase

protocol FoodDealsRepositoryProtocol {
    func findMany() async throws -> [FoodDeals]
    func findByUniversityId(_ universityId: String) async throws -> [FoodDeals]
}

struct FoodDealsRepository: FoodDealsRepositoryProtocol {

    func findMany() async throws -> [FoodDeals] {
        try await SupabaseClientProvider.shared
            .from("food_deals")
            .select()
            .execute()
            .value
    }

    func findByUniversityId(_ universityId: String) async throws -> [FoodDeals] {
        try await SupabaseClientProvider.shared
            .from("food_deals")
            .select()
            .eq("university_id", value: universityId)
            .execute()
            .value
    }
}

