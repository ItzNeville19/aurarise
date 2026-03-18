import SwiftUI

struct RitualView: View {
    @EnvironmentObject var appState: AppState
    @State var showLockInScreen = false
    @State var selectedTrick: Trick?

    var body: some View {
        NavigationStack {
            ZStack {
                StompColors.background.ignoresSafeArea()

                if let session = appState.currentSession {
                    // Active session view
                    ActiveRitualView(session: session, showLockInScreen: $showLockInScreen)
                } else {
                    // Ritual setup view
                    RitualSetupView(selectedTrick: $selectedTrick)
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showLockInScreen, content: {
            if let session = appState.currentSession {
                LockInFullScreen(session: session)
                    .environmentObject(appState)
            }
        })
    }
}

// MARK: - Active Ritual View

struct ActiveRitualView: View {
    let session: Session
    @Binding var showLockInScreen: Bool
    @EnvironmentObject var appState: AppState

    var trick: Trick? {
        appState.tricksForSport(session.sport).first { $0.name == session.activeTrick }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: StompSpacing.lg) {
                // Sport header
                VStack(spacing: StompSpacing.xs) {
                    Text(session.sport.displayName)
                        .font(StompTypography.captionLarge)
                        .foregroundColor(StompColors.textSecondary)
                        .tracking(1)

                    Text(session.activeTrick)
                        .font(StompTypography.displayMedium)
                        .foregroundColor(StompColors.textPrimary)
                }
                .padding(.top, StompSpacing.lg)

                // Trick details
                if let trick = trick {
                    TrickDetailsCard(trick: trick)
                }

                // Current issue
                VStack(alignment: .leading, spacing: StompSpacing.sm) {
                    Text("Current Issue")
                        .font(StompTypography.captionLarge)
                        .foregroundColor(StompColors.textSecondary)
                        .tracking(1)

                    Text(session.sport.commonIssues.first ?? "commitment")
                        .font(StompTypography.bodyLarge)
                        .foregroundColor(StompColors.textPrimary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(StompSpacing.md)
                .stompSurface()

                // Accountability line
                VStack(alignment: .leading, spacing: StompSpacing.sm) {
                    Text("Your Commitment")
                        .font(StompTypography.captionLarge)
                        .foregroundColor(StompColors.textSecondary)
                        .tracking(1)

                    Text("No backing off. Send it with intention.")
                        .font(StompTypography.headingSmall)
                        .foregroundColor(StompColors.accent)
                        .lineLimit(3)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(StompSpacing.md)
                .stompGlassSurface()

                // Next rep tip
                VStack(alignment: .leading, spacing: StompSpacing.sm) {
                    Text("This Rep")
                        .font(StompTypography.captionLarge)
                        .foregroundColor(StompColors.textSecondary)
                        .tracking(1)

                    Text("Commit before the lip. Finish rotation. Trust the air.")
                        .font(StompTypography.bodyLarge)
                        .foregroundColor(StompColors.textPrimary)
                        .lineLimit(4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(StompSpacing.md)
                .stompSurface()

                // Rep counter
                HStack(spacing: StompSpacing.md) {
                    VStack(spacing: StompSpacing.xs) {
                        Text("Reps")
                            .font(StompTypography.captionSmall)
                            .foregroundColor(StompColors.textSecondary)

                        Text("\(session.repCount)")
                            .font(StompTypography.monoLarge)
                            .foregroundColor(StompColors.textPrimary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(StompSpacing.md)
                    .stompSurface()

                    VStack(spacing: StompSpacing.xs) {
                        Text("Success Rate")
                            .font(StompTypography.captionSmall)
                            .foregroundColor(StompColors.textSecondary)

                        Text("\(Int(session.successRate * 100))%")
                            .font(StompTypography.monoLarge)
                            .foregroundColor(StompColors.success)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(StompSpacing.md)
                    .stompSurface()
                }

                // Lock in button
                Button(action: {
                    showLockInScreen = true
                }) {
                    Text("LOCK IN")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .tracking(2)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, StompSpacing.lg)
                        .background(StompColors.accent)
                        .foregroundColor(.white)
                        .cornerRadius(StompRadius.md)
                }
                .padding(.vertical, StompSpacing.lg)
            }
            .padding(.horizontal, StompSpacing.md)
            .padding(.bottom, StompSpacing.lg)
        }
    }
}

// MARK: - Ritual Setup View

struct RitualSetupView: View {
    @EnvironmentObject var appState: AppState
    @Binding var selectedTrick: Trick?
    @State var showTrickSelection = false

    var body: some View {
        ScrollView {
            VStack(spacing: StompSpacing.xl) {
                // Header
                VStack(spacing: StompSpacing.sm) {
                    Text("STOMP")
                        .font(StompTypography.displayLarge)
                        .foregroundColor(StompColors.accent)
                        .tracking(2)

                    Text("Lock in before you go")
                        .font(StompTypography.bodyLarge)
                        .foregroundColor(StompColors.textSecondary)
                }
                .padding(.vertical, StompSpacing.lg)

                // Sport selection
                VStack(alignment: .leading, spacing: StompSpacing.md) {
                    Text("Select Sport")
                        .font(StompTypography.headingSmall)
                        .foregroundColor(StompColors.textPrimary)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: StompSpacing.sm) {
                            ForEach(Sport.allCases) { sport in
                                SportButton(
                                    sport: sport,
                                    isSelected: appState.selectedSport == sport,
                                    action: {
                                        appState.selectedSport = sport
                                        selectedTrick = nil
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, StompSpacing.xs)
                    }
                }

                // Trick selection
                VStack(alignment: .leading, spacing: StompSpacing.md) {
                    Text("Select Trick / Focus")
                        .font(StompTypography.headingSmall)
                        .foregroundColor(StompColors.textPrimary)

                    VStack(spacing: StompSpacing.sm) {
                        let tricks = appState.tricksForSport(appState.selectedSport)
                        ForEach(tricks.prefix(8)) { trick in
                            TrickSelectButton(
                                trick: trick,
                                isSelected: selectedTrick?.id == trick.id,
                                action: {
                                    selectedTrick = trick
                                }
                            )
                        }
                    }
                }

                // Start session button
                if let trick = selectedTrick {
                    Button(action: {
                        appState.startSession(with: trick.name)
                    }) {
                        Text("START SESSION")
                            .font(.system(size: 18, weight: .bold))
                            .tracking(1.5)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, StompSpacing.md)
                            .background(StompColors.accent)
                            .foregroundColor(.white)
                            .cornerRadius(StompRadius.md)
                    }
                    .padding(.vertical, StompSpacing.lg)
                }

                Spacer()
            }
            .padding(.horizontal, StompSpacing.md)
        }
    }
}

// MARK: - Component: Sport Button

struct SportButton: View {
    let sport: Sport
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(sport.displayName)
                    .font(.system(size: 11, weight: .semibold))
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .foregroundColor(isSelected ? .white : StompColors.textSecondary)
            .background(isSelected ? StompColors.accent : StompColors.surfaceSecondary)
            .cornerRadius(StompRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: StompRadius.md)
                    .stroke(isSelected ? StompColors.accent : StompColors.border, lineWidth: 1)
            )
        }
    }
}

// MARK: - Component: Trick Select Button

struct TrickSelectButton: View {
    let trick: Trick
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: StompSpacing.md) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(trick.name)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)

                    Text(trick.description)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(StompColors.textSecondary)
                        .lineLimit(1)
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(StompColors.accent)
                }
            }
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

// MARK: - Component: Trick Details Card

struct TrickDetailsCard: View {
    let trick: Trick

    var body: some View {
        VStack(alignment: .leading, spacing: StompSpacing.md) {
            HStack(spacing: StompSpacing.sm) {
                Text(trick.category)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(StompColors.accent)

                Spacer()

                Text(trick.progressionLevel.rawValue)
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(StompColors.textSecondary)
            }

            VStack(alignment: .leading, spacing: StompSpacing.sm) {
                Text("Common Failure")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(StompColors.textSecondary)

                Text(trick.commonFailure)
                    .font(StompTypography.bodySmall)
                    .foregroundColor(StompColors.textPrimary)
            }

            VStack(alignment: .leading, spacing: StompSpacing.sm) {
                Text("Mental Block")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(StompColors.textSecondary)

                Text(trick.mentalBlock)
                    .font(StompTypography.bodySmall)
                    .foregroundColor(StompColors.textPrimary)
            }
        }
        .padding(StompSpacing.md)
        .stompSurface()
    }
}

#Preview {
    RitualView()
        .environmentObject(AppState())
}
