import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState
    @State var showClearDataAlert = false

    var body: some View {
        NavigationStack {
            ZStack {
                StompColors.background.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: StompSpacing.lg) {
                        // Header
                        VStack(alignment: .leading, spacing: StompSpacing.sm) {
                            Text("Settings"
                            )
                            .font(StompTypography.captionLarge)
                            .foregroundColor(StompColors.textSecondary)
                            .tracking(1)

                            Text("Customize Your Experience")
                                .font(StompTypography.headingLarge)
                                .foregroundColor(StompColors.textPrimary)
                        }
                        .padding(.vertical, StompSpacing.lg)

                        // Premium section
                        VStack(alignment: .leading, spacing: StompSpacing.md) {
                            Text("Premium")
                                .font(StompTypography.headingSmall)
                                .foregroundColor(StompColors.textPrimary)

                            VStack(spacing: StompSpacing.sm) {
                                SettingRow(
                                    label: "Premium Status",
                                    value: appState.isPremium ? "Active" : "Free"
                                )

                                if !appState.isPremium {
                                    Button(action: {
                                        // Navigate to paywall
                                    }) {
                                        Text("UPGRADE TO PREMIUM")
                                            .font(.system(size: 16, weight: .bold))
                                            .tracking(1)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, StompSpacing.md)
                                            .background(StompColors.accent)
                                            .foregroundColor(.white)
                                            .cornerRadius(StompRadius.md)
                                    }
                                } else {
                                    Button(action: {}) {
                                        Text("MANAGE SUBSCRIPTION")
                                            .font(.system(size: 16, weight: .semibold))
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, StompSpacing.md)
                                            .foregroundColor(StompColors.textPrimary)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: StompRadius.md)
                                                    .stroke(StompColors.border, lineWidth: 1)
                                            )
                                    }
                                }
                            }
                            .padding(StompSpacing.md)
                            .stompSurface()
                        }

                        // App settings
                        VStack(alignment: .leading, spacing: StompSpacing.md) {
                            Text("App")
                                .font(StompTypography.headingSmall)
                                .foregroundColor(StompColors.textPrimary)

                            VStack(spacing: 0) {
                                SettingRow(label: "Theme", value: "Dark Mode")
                                Divider().background(StompColors.border)
                                SettingRow(label: "Haptics", value: "Enabled")
                                Divider().background(StompColors.border)
                                SettingRow(label: "Notifications", value: "Enabled")
                            }
                            .padding(StompSpacing.md)
                            .stompSurface()
                        }

                        // Data
                        VStack(alignment: .leading, spacing: StompSpacing.md) {
                            Text("Data")
                                .font(StompTypography.headingSmall)
                                .foregroundColor(StompColors.textPrimary)

                            VStack(spacing: StompSpacing.sm) {
                                SettingRow(
                                    label: "Total Sessions",
                                    value: "\(appState.sessionHistory.count)"
                                )

                                SettingRow(
                                    label: "Total Reps",
                                    value: "\(appState.sessionHistory.flatMap { $0.reps }.count)"
                                )

                                Button(action: { showClearDataAlert = true }) {
                                    HStack {
                                        Text("Clear All Data")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(StompColors.failure)

                                        Spacer()

                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(StompColors.failure)
                                    }
                                    .padding(StompSpacing.md)
                                }
                                .alert("Clear All Data?", isPresented: $showClearDataAlert) {
                                    Button("Cancel", role: .cancel) {}
                                    Button("Clear", role: .destructive) {
                                        // Clear data
                                    }
                                } message: {
                                    Text("This cannot be undone.")
                                }
                            }
                            .padding(StompSpacing.md)
                            .stompSurface()
                        }

                        // About
                        VStack(alignment: .leading, spacing: StompSpacing.md) {
                            Text("About")
                                .font(StompTypography.headingSmall)
                                .foregroundColor(StompColors.textPrimary)

                            VStack(spacing: 0) {
                                SettingRow(label: "App Version", value: "1.0.0")
                                Divider().background(StompColors.border)
                                SettingRow(label: "Build", value: "1")
                            }
                            .padding(StompSpacing.md)
                            .stompSurface()
                        }

                        Spacer(minLength: StompSpacing.lg)
                    }
                    .padding(.horizontal, StompSpacing.md)
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Component: Setting Row

struct SettingRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(StompColors.textPrimary)

            Spacer()

            Text(value)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(StompColors.textSecondary)
        }
        .padding(.vertical, StompSpacing.sm)
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppState())
}
