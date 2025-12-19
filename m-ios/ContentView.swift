import SwiftUI

struct ContentView: View {
    @StateObject private var universitiesVM = UniversitiesViewModel()
    @StateObject private var foodDealsVM = FoodDealsViewModel()

    var body: some View {
        NavigationView {
            List {
                universitiesSection
                foodDealsSection
            }
            .overlay(overlayView)
            .navigationTitle("SneakOut")
            .task {
                await loadAll()
            }
        }
    }


    private var universitiesSection: some View {
        Section("Universities") {
            ForEach(universitiesVM.universities) { university in
                Text(university.name)
            }
        }
    }

    private var foodDealsSection: some View {
        Section("Food Deals") {
            ForEach(foodDealsVM.foodDeals) { deal in
                VStack(alignment: .leading, spacing: 4) {
                    Text(deal.title)
                        .font(.headline)
                    if let university = universitiesVM.universities.first(where: { $0.id == deal.universityId }) {
                        Text(university.name)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }


    private var overlayView: some View {
        Group {
            if universitiesVM.isLoading || foodDealsVM.isLoading {
                ProgressView()
            } else if let error = universitiesVM.loadError ?? foodDealsVM.loadError {
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if universitiesVM.universities.isEmpty && foodDealsVM.foodDeals.isEmpty {
                Text("No data")
                    .foregroundColor(.secondary)
            }
        }
    }


    private func loadAll() async {
        async let loadUniversities = universitiesVM.load()
        async let loadFoodDeals = foodDealsVM.load()
        _ = await (loadUniversities, loadFoodDeals)
    }
}
