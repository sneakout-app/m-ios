import Foundation
import Supabase

protocol UniversitiesRepositoryProtocol {
    func findMany() async throws -> [Universities]
    func findById(_ id: String) async throws -> Universities?
}

struct UniversitiesRepository: UniversitiesRepositoryProtocol {

    func findMany() async throws -> [Universities] {
        try await SupabaseClientProvider.shared
            .from("universities")
            .select()
            .execute()
            .value
    }

    func findById(_ id: String) async throws -> Universities? {
        try await SupabaseClientProvider.shared
            .from("universities")
            .select()
            .eq("id", value: id)
            .single()
            .execute()
            .value
        return nil
    }
}
