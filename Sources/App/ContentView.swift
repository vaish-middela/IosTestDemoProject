import SwiftUI

struct ContentView: View {
    @State private var showMessage = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Hello World!")
                    .accessibilityIdentifier("greeting")

                Button("Email action") {
                    showMessage = true
                }
                .accessibilityIdentifier("emailActionButton")
            }
            .navigationTitle("Practice App")
            .alert("Hello from the app", isPresented: $showMessage) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}