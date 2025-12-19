import SwiftUI
import Foundation
import Supabase

let supabase = SupabaseClient(
  supabaseURL: URL(string: "https://yiuejlyxnfwhxhlnqlcd.supabase.co")!,
  supabaseKey: "sb_publishable_1wagIVx1J5-QoaQku-jmag_drH3Ka95"
)

struct ContentView: View {
    @State private var universities: [Universities] = []
    @State private var food_deals: [FoodDeals] = []
    @State private var isLoading = true
    @State private var loadError: Error?

    var body: some View {
        NavigationView {
            List {
                universitiesSection
                foodDealsSection
            }
            .overlay(overlayView)
            .navigationTitle("SneakOut")
            .task {
                await loadData()
            }
        }
    }

    private var universitiesSection: some View {
        Section("Universities") {
            ForEach(universities) { university in
                Text(university.name)
            }
        }
    }

    private var foodDealsSection: some View {
        Section("Food Deals") {
            ForEach(food_deals) { deal in
                VStack(alignment: .leading, spacing: 4) {
                    Text(deal.title)
                        .font(.headline)
                    if let university = universities.first(where: { $0.id == deal.universityId }) {
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
            if isLoading {
                ProgressView()
            } else if let loadError {
                Text("Error: \(loadError.localizedDescription)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if universities.isEmpty && food_deals.isEmpty {
                Text("No data")
                    .foregroundColor(.secondary)
            }
        }
    }
    
    func loadData() async {
        isLoading = true
        loadError = nil
        do {
            let universitiesResult: [Universities] = try await supabase
                .from("universities")
                .select()
                .execute()
                .value

            let foodDealsResult: [FoodDeals] = try await supabase
                .from("food_deals")
                .select()
                .execute()
                .value

            universities = universitiesResult
            food_deals = foodDealsResult
        } catch {
            loadError = error
        }
        isLoading = false
    }
}
