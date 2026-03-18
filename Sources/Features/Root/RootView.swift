import SwiftUI

struct RootView: View {
    @StateObject var appState = AppState()
    @State var selectedTab: AppTab = .ritual

    var body: some View {
        ZStack {
            // Background
            StompColors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                // Active content
                TabView(selection: $selectedTab) {
                    RitualView()
                        .tag(AppTab.ritual)

                    SessionView()
                        .tag(AppTab.session)

                    ProgressView()
                        .tag(AppTab.progress)

                    LibraryView()
                        .tag(AppTab.library)

                    SettingsView()
                        .tag(AppTab.settings)
                }

                // Tab bar
                StompTabBar(selectedTab: $selectedTab)
            }
        }
        .environmentObject(appState)
        .preferredColorScheme(.dark)
    }
}

enum AppTab: Equatable {
    case ritual
    case session
    case progress
    case library
    case settings
}

// MARK: - Tab Bar

struct StompTabBar: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .background(StompColors.border)

            HStack(spacing: 0) {
                TabBarItem(
                    icon: "flame.fill",
                    label: "Ritual",
                    isSelected: selectedTab == .ritual,
                    action: { selectedTab = .ritual }
                )

                TabBarItem(
                    icon: "circle.fill",
                    label: "Session",
                    isSelected: selectedTab == .session,
                    action: { selectedTab = .session }
                )

                TabBarItem(
                    icon: "chart.bar.fill",
                    label: "Progress",
                    isSelected: selectedTab == .progress,
                    action: { selectedTab = .progress }
                )

                TabBarItem(
                    icon: "book.fill",
                    label: "Library",
                    isSelected: selectedTab == .library,
                    action: { selectedTab = .library }
                )

                TabBarItem(
                    icon: "gear.fill",
                    label: "Settings",
                    isSelected: selectedTab == .settings,
                    action: { selectedTab = .settings }
                )
            }
            .padding(.horizontal, StompSpacing.xs)
            .padding(.vertical, StompSpacing.sm)
            .background(StompColors.surfacePrimary)
        }
    }
}

struct TabBarItem: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))

                Text(label)
                    .font(.system(size: 11, weight: .semibold))
            }
            .foregroundColor(isSelected ? StompColors.accent : StompColors.textTertiary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, StompSpacing.sm)
        }
    }
}

#Preview {
    RootView()
}
