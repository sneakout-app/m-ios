import Foundation

@MainActor
final class FoodDealsViewModel: ObservableObject {
    @Published var foodDeals: [FoodDeals] = []
    @Published var isLoading = false
    @Published var loadError: Error?

    private let repository: FoodDealsRepositoryProtocol

    init(repository: FoodDealsRepositoryProtocol = FoodDealsRepository()) {
        self.repository = repository
    }

    func load() async {
        isLoading = true
        loadError = nil
        do {
            foodDeals = try await repository.findMany()
        } catch {
            loadError = error
        }
        isLoading = false
    }
}
