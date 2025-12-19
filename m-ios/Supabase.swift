import Foundation
import Supabase

enum SupabaseClientProvider {
    static let shared = SupabaseClient(
        supabaseURL: URL(string: "https://yiuejlyxnfwhxhlnqlcd.supabase.co")!,
        supabaseKey: "sb_publishable_1wagIVx1J5-QoaQku-jmag_drH3Ka95"
    )
}
