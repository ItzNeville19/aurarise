import SwiftUI

struct PaywallView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    @State var selectedPlan: PremiumPlan = .monthly
    @State var showProcessing = false

    var body: some View {
        ZStack {
            StompColors.background.ignoresSafeArea()

            VStack(spacing: StompSpacing.lg) {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(StompColors.textSecondary)
                    }
                    Spacer()
                }
                .padding(StompSpacing.md)

                ScrollView {
                    VStack(spacing: StompSpacing.lg) {
                        // Title
                        VStack(spacing: StompSpacing.md) {
                            Text("STOMP Premium")
                                .font(StompTypography.headingLarge)
                                .foregroundColor(StompColors.accent)

                            Text("Everything you need to perform at your best")
                                .font(StompTypography.bodyMedium)
                                .foregroundColor(StompColors.textSecondary)
                                .multilineTextAlignment(.center)
                        }

                        // Feature list
                        VStack(alignment: .leading, spacing: StompSpacing.md) {
                            ForEach([
                                ("flame.fill", "Unlimited sessions", "Track every rep"),
                                ("book.fill", "Full trick library", "All sports, all levels"),
                                ("chart.bar.fill", "Advanced analytics", "Detailed progress insights"),
                                ("brain.head.profile", "Smart tips", "Contextual guidance per rep"),
                                ("target", "Accountability memory", "Never repeat mistakes"),
                                ("sparkles", "Premium cues", "Sport-specific language"),
                            ], id: \.1) { icon, feature, subtitle in
                                HStack(spacing: StompSpacing.md) {
                                    Image(systemName: icon)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(StompColors.accent)
                                        .frame(width: 30)

                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(feature)
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(StompColors.textPrimary)

                                        Text(subtitle)
                                            .font(.system(size: 12, weight: .regular))
                                            .foregroundColor(StompColors.textSecondary)
                                    }

                                    Spacer()
                                }
                            }
                        }
                        .padding(StompSpacing.md)
                        .stompSurface()

                        // Plan selection
                        VStack(alignment: .leading, spacing: StompSpacing.md) {
                            Text("Choose Your Plan")
                                .font(StompTypography.headingSmall)
                                .foregroundColor(StompColors.textPrimary)

                            VStack(spacing: StompSpacing.sm) {
                                PlanButton(
                                    plan: .monthly,
                                    isSelected: selectedPlan == .monthly,
                                    action: { selectedPlan = .monthly }
                                )

                                PlanButton(
                                    plan: .annual,
                                    isSelected: selectedPlan == .annual,
                                    action: { selectedPlan = .annual }
                                )
                            }
                        }

                        // CTA button
                        Button(action: {
                            showProcessing = true
                            // RevenueCat would handle purchase here
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                // Mock successful purchase
                                appState.isPremium = true
                                dismiss()
                            }
                        }) {
                            if showProcessing {
                                HStack(spacing: StompSpacing.sm) {
                                    ProgressView()
                                        .tint(.white)

                                    Text("Processing...")
                                        .font(.system(size: 16, weight: .bold))
                                }
                            } else {
                                Text("SUBSCRIBE - \(selectedPlan.price)")
                                    .font(.system(size: 16, weight: .bold))
                                    .tracking(1)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, StompSpacing.md)
                        .foregroundColor(.white)
                        .background(StompColors.accent)
                        .cornerRadius(StompRadius.md)
                        .disabled(showProcessing)

                        // Bottom text
                        VStack(alignment: .center, spacing: StompSpacing.sm) {
                            Text("Auto-renews. Cancel anytime.")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(StompColors.textTertiary)

                            HStack(spacing: StompSpacing.xs) {
                                Button(action: {}) {
                                    Text("Terms")
                                        .font(.system(size: 11, weight: .regular))
                                        .foregroundColor(StompColors.accent)
                                }

                                Text("•")
                                    .foregroundColor(StompColors.textTertiary)

                                Button(action: {}) {
                                    Text("Privacy")
                                        .font(.system(size: 11, weight: .regular))
                                        .foregroundColor(StompColors.accent)
                                }

                                Text("•")
                                    .foregroundColor(StompColors.textTertiary)

                                Button(action: {}) {
                                    Text("Restore")
                                        .font(.system(size: 11, weight: .regular))
                                        .foregroundColor(StompColors.accent)
                                }
                            }
                        }
                        .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, StompSpacing.md)
                }
            }
        }
    }
}

// MARK: - Plan Button

struct PlanButton: View {
    let plan: PremiumPlan
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: StompSpacing.md) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(plan.name)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(isSelected ? .white : StompColors.textPrimary)

                    Text(plan.description)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(isSelected ? StompColors.textSecondary : StompColors.textSecondary)
                }

                Spacer()

                Text(plan.price)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(isSelected ? StompColors.accent : StompColors.textPrimary)

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 18))
                        .foregroundColor(StompColors.accent)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(StompSpacing.md)
            .background(isSelected ? StompColors.surfaceSecondary : StompColors.surfacePrimary)
            .cornerRadius(StompRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: StompRadius.md)
                    .stroke(isSelected ? StompColors.accent : StompColors.border, lineWidth: isSelected ? 2 : 1)
            )
        }
    }
}

// MARK: - Premium Plan

enum PremiumPlan: Equatable {
    case monthly
    case annual

    var name: String {
        switch self {
        case .monthly: return "Monthly"
        case .annual: return "Annual"
        }
    }

    var description: String {
        switch self {
        case .monthly: return "Per month, cancel anytime"
        case .annual: return "Billed yearly, save 20%"
        }
    }

    var price: String {
        switch self {
        case .monthly: return "$9.99/mo"
        case .annual: return "$79.99/yr"
        }
    }
}

#Preview {
    PaywallView()
        .environmentObject(AppState())
}
