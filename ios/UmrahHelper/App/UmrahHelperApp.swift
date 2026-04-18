import SwiftUI
import SwiftData

@main
struct UmrahHelperApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: UmrahSession.self)
    }
}
