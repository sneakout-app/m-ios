import Foundation

@MainActor
final class UniversitiesViewModel: ObservableObject {
    @Published var universities: [Universities] = []
    @Published var isLoading = false
    @Published var loadError: Error?

    private let repository: UniversitiesRepositoryProtocol

    init(repository: UniversitiesRepositoryProtocol = UniversitiesRepository()) {
        self.repository = repository
    }

    func load() async {
        isLoading = true
        loadError = nil
        do {
            universities = try await repository.findMany()
        } catch {
            loadError = error
        }
        isLoading = false
    }
}
