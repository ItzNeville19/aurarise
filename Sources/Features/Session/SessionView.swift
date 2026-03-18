import SwiftUI

struct SessionView: View {
    @EnvironmentObject var appState: AppState
    @State var showPostRepSheet = false

    var body: some View {
        NavigationStack {
            ZStack {
                StompColors.background.ignoresSafeArea()

                if let session = appState.currentSession {
                    ActiveSessionView(session: session, showPostRepSheet: $showPostRepSheet)
                } else {
                    NoActiveSessionView()
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Active Session View

struct ActiveSessionView: View {
    @EnvironmentObject var appState: AppState
    let session: Session
    @Binding var showPostRepSheet: Bool

    var body: some View {
        ScrollView {
            VStack(spacing: StompSpacing.lg) {
                // Header
                VStack(alignment: .leading, spacing: StompSpacing.sm) {
                    Text("Active Session")
                        .font(StompTypography.captionLarge)
                        .foregroundColor(StompColors.textSecondary)
                        .tracking(1)

                    Text(session.sport.displayName)
                        .font(StompTypography.headingLarge)
                        .foregroundColor(StompColors.textPrimary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, StompSpacing.lg)

                // Session stats
                HStack(spacing: StompSpacing.md) {
                    StatCard(label: "Reps", value: "\(session.repCount)", color: StompColors.accent)
                    StatCard(label: "Success", value: "\(Int(session.successRate * 100))%", color: StompColors.success)
                    StatCard(label: "Time", value: "8m", color: StompColors.textSecondary)
                }

                // Rep history
                VStack(alignment: .leading, spacing: StompSpacing.md) {
                    Text("Rep History")
                        .font(StompTypography.headingSmall)
                        .foregroundColor(StompColors.textPrimary)

                    if session.reps.isEmpty {
                        VStack(spacing: StompSpacing.md) {
                            Text("No reps logged yet")
                                .font(StompTypography.bodyMedium)
                                .foregroundColor(StompColors.textSecondary)
                            Text("Lock in and send your first rep")
                                .font(StompTypography.bodySmall)
                                .foregroundColor(StompColors.textTertiary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(StompSpacing.lg)
                        .background(StompColors.surfacePrimary)
                        .cornerRadius(StompRadius.md)
                    } else {
                        VStack(spacing: StompSpacing.sm) {
                            ForEach(session.reps.reversed()) { rep in
                                RepRow(rep: rep)
                            }
                        }
                    }
                }

                // Action buttons
                VStack(spacing: StompSpacing.md) {
                    Button(action: {
                        showPostRepSheet = true
                    }) {
                        Text("LOG REP")
                            .font(.system(size: 16, weight: .bold))
                            .tracking(1)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, StompSpacing.md)
                            .background(StompColors.accent)
                            .foregroundColor(.white)
                            .cornerRadius(StompRadius.md)
                    }

                    Button(action: {
                        appState.endSession()
                    }) {
                        Text("END SESSION")
                            .font(.system(size: 16, weight: .semibold))
                            .tracking(1)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, StompSpacing.md)
                            .foregroundColor(StompColors.textPrimary)
                            .overlay(
                                RoundedRectangle(cornerRadius: StompRadius.md)
                                    .stroke(StompColors.border, lineWidth: 1)
                            )
                    }
                }
                .padding(.vertical, StompSpacing.lg)
            }
            .padding(.horizontal, StompSpacing.md)
        }
    }
}

// MARK: - No Active Session View

struct NoActiveSessionView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: StompSpacing.lg) {
            Spacer()

            VStack(spacing: StompSpacing.md) {
                Image(systemName: "circle.fill")
                    .font(.system(size: 48))
                    .foregroundColor(StompColors.textSecondary)

                Text("No active session")
                    .font(StompTypography.headingSmall)
                    .foregroundColor(StompColors.textPrimary)

                Text("Start a session from the Ritual tab to begin tracking")
                    .font(StompTypography.bodySmall)
                    .foregroundColor(StompColors.textSecondary)
                    .multilineTextAlignment(.center)
            }

            Spacer()

            Button(action: {
                // Navigate to ritual
            }) {
                Text("GO TO RITUAL")
                    .font(.system(size: 16, weight: .bold))
                    .tracking(1)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, StompSpacing.md)
                    .background(StompColors.accent)
                    .foregroundColor(.white)
                    .cornerRadius(StompRadius.md)
            }
            .padding(.bottom, StompSpacing.lg)
        }
        .padding(.horizontal, StompSpacing.md)
    }
}

// MARK: - Component: Stat Card

struct StatCard: View {
    let label: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: StompSpacing.xs) {
            Text(label)
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(StompColors.textSecondary)

            Text(value)
                .font(StompTypography.monoMedium)
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
        .padding(StompSpacing.md)
        .stompSurface()
    }
}

// MARK: - Component: Rep Row

struct RepRow: View {
    let rep: Rep

    var body: some View {
        HStack(spacing: StompSpacing.md) {
            Text(rep.outcome.emoji)
                .font(.system(size: 20))

            VStack(alignment: .leading, spacing: 2) {
                Text(rep.outcome.displayName)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(StompColors.textPrimary)

                HStack(spacing: StompSpacing.sm) {
                    Text(rep.timestamp.formatted(date: .omitted, time: .shortened))
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(StompColors.textSecondary)

                    if rep.commitment {
                        Text("• committed")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(StompColors.accent)
                    }

                    if let issueTag = rep.issueTag {
                        Text("• \(issueTag)")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(StompColors.warning)
                    }
                }
            }

            Spacer()
        }
        .padding(StompSpacing.md)
        .stompSurface()
    }
}

#Preview {
    SessionView()
        .environmentObject(AppState())
}
