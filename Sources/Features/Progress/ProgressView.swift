import SwiftUI

struct ProgressView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack {
            ZStack {
                StompColors.background.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: StompSpacing.lg) {
                        // Header
                        VStack(alignment: .leading, spacing: StompSpacing.sm) {
                            Text("Performance")
                                .font(StompTypography.captionLarge)
                                .foregroundColor(StompColors.textSecondary)
                                .tracking(1)

                            Text("Your Progress")
                                .font(StompTypography.headingLarge)
                                .foregroundColor(StompColors.textPrimary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, StompSpacing.lg)

                        // Key metrics
                        VStack(spacing: StompSpacing.md) {
                            MetricCard(
                                label: "Commitment Rate",
                                value: "\(Int(appState.commitmentRate() * 100))%",
                                subtitle: "Reps where you locked in",
                                color: StompColors.accent
                            )

                            MetricCard(
                                label: "Success Rate",
                                value: "\(Int(appState.successRate() * 100))%",
                                subtitle: "Reps sent successfully",
                                color: StompColors.success
                            )

                            MetricCard(
                                label: "Consistency Score",
                                value: "\(appState.consistencyScore())",
                                subtitle: "Commitment + Success",
                                color: StompColors.accentLight
                            )
                        }

                        // Streaks
                        VStack(alignment: .leading, spacing: StompSpacing.md) {
                            Text("Streaks")
                                .font(StompTypography.headingSmall)
                                .foregroundColor(StompColors.textPrimary)

                            HStack(spacing: StompSpacing.md) {
                                StreakCard(
                                    icon: "flame.fill",
                                    label: "Commit Streak",
                                    value: appState.commitStreak,
                                    color: StompColors.accent
                                )

                                StreakCard(
                                    icon: "checkmark.circle.fill",
                                    label: "Success Streak",
                                    value: appState.successStreak,
                                    color: StompColors.success
                                )
                            }
                        }

                        // Recent sessions
                        VStack(alignment: .leading, spacing: StompSpacing.md) {
                            Text("Recent Sessions")
                                .font(StompTypography.headingSmall)
                                .foregroundColor(StompColors.textPrimary)

                            if appState.sessionHistory.isEmpty {
                                VStack(spacing: StompSpacing.md) {
                                    Text("No sessions yet")
                                        .font(StompTypography.bodyMedium)
                                        .foregroundColor(StompColors.textSecondary)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(StompSpacing.lg)
                                .background(StompColors.surfacePrimary)
                                .cornerRadius(StompRadius.md)
                            } else {
                                VStack(spacing: StompSpacing.sm) {
                                    ForEach(appState.sessionHistory.reversed().prefix(5)) { session in
                                        SessionSummaryRow(session: session)
                                    }
                                }
                            }
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

// MARK: - Component: Metric Card

struct MetricCard: View {
    let label: String
    let value: String
    let subtitle: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: StompSpacing.sm) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(label)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(StompColors.textSecondary)

                    Text(value)
                        .font(StompTypography.displaySmall)
                        .foregroundColor(color)
                }

                Spacer()
            }

            Text(subtitle)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(StompColors.textTertiary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(StompSpacing.md)
        .stompSurface()
    }
}

// MARK: - Component: Streak Card

struct StreakCard: View {
    let icon: String
    let label: String
    let value: Int
    let color: Color

    var body: some View {
        VStack(spacing: StompSpacing.sm) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(color)

            Text(value.description)
                .font(StompTypography.monoLarge)
                .foregroundColor(StompColors.textPrimary)

            Text(label)
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(StompColors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(StompSpacing.md)
        .stompSurface()
    }
}

// MARK: - Component: Session Summary Row

struct SessionSummaryRow: View {
    let session: Session

    var body: some View {
        HStack(spacing: StompSpacing.md) {
            VStack(alignment: .leading, spacing: 4) {
                Text(session.sport.displayName)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(StompColors.textPrimary)

                HStack(spacing: StompSpacing.sm) {
                    Text("\(session.repCount) \(session.sport.repName)s")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(StompColors.textSecondary)

                    Text("•")
                        .foregroundColor(StompColors.textTertiary)

                    Text(session.date.formatted(date: .abbreviated, time: .shortened))
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(StompColors.textSecondary)
                }
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("\(Int(session.successRate * 100))%")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(StompColors.success)

                Text("success")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(StompColors.textTertiary)
            }
        }
        .padding(StompSpacing.md)
        .stompSurface()
    }
}

#Preview {
    ProgressView()
        .environmentObject(AppState())
}
