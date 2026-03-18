import SwiftUI

struct LockInFullScreen: View {
    let session: Session
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    @State var isHoldingDown = false
    @State var holdProgress: CGFloat = 0
    @State var showConfirmation = false
    @State var selectedOutcome: RepOutcome?

    let holdDuration = 2.0

    var body: some View {
        ZStack {
            // Absolute black background
            Color(red: 0.02, green: 0.02, blue: 0.03).ignoresSafeArea()

            VStack(spacing: 0) {
                // Close button
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(StompColors.textSecondary)
                            .padding(StompSpacing.md)
                    }
                    Spacer()
                }
                .padding(.top, StompSpacing.md)

                Spacer()

                // Main message
                VStack(spacing: StompSpacing.lg) {
                    Text(session.sport.displayName)
                        .font(StompTypography.captionLarge)
                        .foregroundColor(StompColors.textSecondary)
                        .tracking(2)

                    Text(session.activeTrick)
                        .font(StompTypography.displayLarge)
                        .foregroundColor(StompColors.textPrimary)
                        .tracking(-2)
                        .lineLimit(2)

                    // Commitment cue
                    Text("No backing off.")
                        .font(StompTypography.headingMedium)
                        .foregroundColor(StompColors.accent)
                        .tracking(1)
                        .lineLimit(2)
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)

                Spacer()

                // Hold to commit button with progress
                VStack(spacing: StompSpacing.lg) {
                    if showConfirmation {
                        // Outcome selection
                        OutcomeSelector(
                            selectedOutcome: $selectedOutcome,
                            sport: session.sport
                        )
                    } else {
                        // Hold to commit
                        HoldToCommitButton(
                            isHoldingDown: $isHoldingDown,
                            holdProgress: $holdProgress,
                            holdDuration: holdDuration,
                            onComplete: {
                                showConfirmation = true
                            }
                        )
                    }
                }
                .padding(.horizontal, StompSpacing.lg)
                .padding(.bottom, StompSpacing.xxl)
            }
        }
        .sheet(isPresented: $showConfirmation, onDismiss: { dismiss() }) {
            if let outcome = selectedOutcome {
                PostRepView(
                    session: session,
                    outcome: outcome,
                    onDismiss: { dismiss() }
                )
                .environmentObject(appState)
            }
        }
    }
}

// MARK: - Hold to Commit Button

struct HoldToCommitButton: View {
    @Binding var isHoldingDown: Bool
    @Binding var holdProgress: CGFloat
    let holdDuration: Double
    let onComplete: () -> Void

    var body: some View {
        VStack(spacing: StompSpacing.md) {
            ZStack {
                // Background circle
                Circle()
                    .fill(StompColors.surfaceSecondary)
                    .frame(height: 180)

                // Progress ring
                Circle()
                    .trim(from: 0, to: min(holdProgress, 1.0))
                    .stroke(StompColors.accent, lineWidth: 3)
                    .frame(height: 180)
                    .rotationEffect(.degrees(-90))

                // Text
                VStack(spacing: 8) {
                    Text("HOLD")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(StompColors.textSecondary)

                    Text("LOCK IN")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(StompColors.accent)
                }
            }
            .onLongPressGesture(
                minimumDuration: holdDuration,
                perform: {
                    onComplete()
                },
                onPressingChanged: { isPressing in
                    isHoldingDown = isPressing
                    if isPressing {
                        animateProgress()
                    } else {
                        holdProgress = 0
                    }
                }
            )

            Text("Hold for 2 seconds")
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(StompColors.textTertiary)
        }
    }

    private func animateProgress() {
        holdProgress = 0
        withAnimation(.linear(duration: holdDuration)) {
            holdProgress = 1.0
        }
    }
}

// MARK: - Outcome Selector

struct OutcomeSelector: View {
    @Binding var selectedOutcome: RepOutcome?
    let sport: Sport

    var body: some View {
        VStack(spacing: StompSpacing.md) {
            Text("What happened?")
                .font(StompTypography.headingSmall)
                .foregroundColor(StompColors.textPrimary)

            VStack(spacing: StompSpacing.sm) {
                OutcomeButton(
                    outcome: .success,
                    isSelected: selectedOutcome == .success,
                    action: { selectedOutcome = .success }
                )

                OutcomeButton(
                    outcome: .partial,
                    isSelected: selectedOutcome == .partial,
                    action: { selectedOutcome = .partial }
                )

                OutcomeButton(
                    outcome: .miss,
                    isSelected: selectedOutcome == .miss,
                    action: { selectedOutcome = .miss }
                )

                OutcomeButton(
                    outcome: .bail,
                    isSelected: selectedOutcome == .bail,
                    action: { selectedOutcome = .bail }
                )

                OutcomeButton(
                    outcome: .fail,
                    isSelected: selectedOutcome == .fail,
                    action: { selectedOutcome = .fail }
                )
            }
        }
    }
}

struct OutcomeButton: View {
    let outcome: RepOutcome
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: StompSpacing.md) {
                Text(outcome.emoji)
                    .font(.system(size: 20))

                Text(outcome.displayName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(isSelected ? .white : StompColors.textPrimary)

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 18))
                        .foregroundColor(StompColors.accent)
                }
            }
            .frame(maxWidth: .infinity)
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

// MARK: - Post Rep View

struct PostRepView: View {
    let session: Session
    let outcome: RepOutcome
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss

    @State var note: String = ""
    @State var selectedIssue: String?
    @State var committed = true

    var body: some View {
        ZStack {
            StompColors.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: StompSpacing.lg) {
                    // Header
                    VStack(spacing: StompSpacing.sm) {
                        Text("Rep logged.")
                            .font(StompTypography.headingSmall)
                            .foregroundColor(StompColors.textPrimary)

                        Text("Session: \(appState.currentSession?.repCount ?? 0 + 1)")
                            .font(StompTypography.bodySmall)
                            .foregroundColor(StompColors.textSecondary)
                    }
                    .padding(.top, StompSpacing.lg)

                    // Outcome confirmation
                    HStack(spacing: StompSpacing.md) {
                        Text(outcome.emoji)
                            .font(.system(size: 40))

                        VStack(alignment: .leading, spacing: 4) {
                            Text(outcome.displayName)
                                .font(StompTypography.headingSmall)
                                .foregroundColor(StompColors.textPrimary)

                            Text("Logged at \(Date().formatted(date: .omitted, time: .shortened))")
                                .font(StompTypography.captionSmall)
                                .foregroundColor(StompColors.textSecondary)
                        }

                        Spacer()
                    }
                    .padding(StompSpacing.md)
                    .stompSurface()

                    // Commitment toggle
                    VStack(alignment: .leading, spacing: StompSpacing.sm) {
                        Text("Did you commit?")
                            .font(StompTypography.bodySmall)
                            .foregroundColor(StompColors.textSecondary)

                        Toggle("Yes, I committed", isOn: $committed)
                            .tint(StompColors.accent)
                    }
                    .padding(StompSpacing.md)
                    .stompSurface()

                    // Optional note
                    VStack(alignment: .leading, spacing: StompSpacing.sm) {
                        Text("Quick note (optional)")
                            .font(StompTypography.bodySmall)
                            .foregroundColor(StompColors.textSecondary)

                        TextEditor(text: $note)
                            .frame(height: 80)
                            .padding(8)
                            .background(StompColors.surfaceSecondary)
                            .cornerRadius(StompRadius.md)
                            .foregroundColor(StompColors.textPrimary)
                    }
                    .padding(StompSpacing.md)
                    .stompSurface()

                    // Issue tag
                    VStack(alignment: .leading, spacing: StompSpacing.sm) {
                        Text("Issue tag (optional)")
                            .font(StompTypography.bodySmall)
                            .foregroundColor(StompColors.textSecondary)

                        Picker("Select issue", selection: $selectedIssue) {
                            Text("None").tag(Optional<String>.none)
                            ForEach(session.sport.commonIssues, id: \.self) { issue in
                                Text(issue).tag(Optional(issue))
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .tint(StompColors.accent)
                    }
                    .padding(StompSpacing.md)
                    .stompSurface()

                    // Submit button
                    Button(action: {
                        appState.addRep(
                            commitment: committed,
                            outcome: outcome,
                            note: note.isEmpty ? nil : note,
                            issueTag: selectedIssue
                        )
                        dismiss()
                    }) {
                        Text("CONTINUE")
                            .font(.system(size: 16, weight: .bold))
                            .tracking(1)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, StompSpacing.md)
                            .background(StompColors.accent)
                            .foregroundColor(.white)
                            .cornerRadius(StompRadius.md)
                    }
                    .padding(.vertical, StompSpacing.lg)

                    Spacer()
                }
                .padding(.horizontal, StompSpacing.md)
            }
        }
    }
}

#Preview {
    let session = Session(sport: .freeskiPark, activeTrick: "Cork 7")
    LockInFullScreen(session: session)
        .environmentObject(AppState())
}
