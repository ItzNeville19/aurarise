import Foundation

struct TipService {
    static func nextRepTip(
        sport: Sport,
        trick: String,
        previousOutcome: RepOutcome?,
        recentIssue: String?,
        sessionReps: Int
    ) -> TipResult {
        let explanation = generateExplanation(sport: sport, outcome: previousOutcome, issue: recentIssue)
        let tip = generateTip(sport: sport, trick: trick, outcome: previousOutcome, sessionReps: sessionReps)
        let cue = sport.cueSamples.randomElement() ?? "commit"

        return TipResult(explanation: explanation, tip: tip, cue: cue)
    }

    private static func generateExplanation(
        sport: Sport,
        outcome: RepOutcome?,
        issue: String?
    ) -> String {
        guard let outcome = outcome else {
            return "First rep. Lock in."
        }

        switch outcome {
        case .success:
            return "You committed. Keep that intensity."

        case .bail:
            if let issue = issue {
                return "You bailed on \(issue). That kills momentum."
            }
            return "You bailed. Same setup, different result."

        case .miss:
            return "You missed. Technical issue, not commitment."

        case .partial:
            return "Partial send. Close, but incomplete."

        case .fail:
            if let issue = issue {
                return "Failed on \(issue). Identify the exact moment."
            }
            return "You failed. Why did it break?"
        }
    }

    private static func generateTip(
        sport: Sport,
        trick: String,
        outcome: RepOutcome?,
        sessionReps: Int
    ) -> String {
        let baseRepN = sessionReps + 1

        // Accountability memory
        if outcome == .bail {
            return "Next rep: Send it. No bailout."
        }

        if outcome == .success && sessionReps < 3 {
            return "Next rep: Same intensity, same result."
        }

        if outcome == .miss {
            return "Next rep: Tighten technique. Commit harder."
        }

        // Progressive intensity
        switch baseRepN {
        case 1:
            return "First rep. Prove to yourself you can do it."
        case 2:
            return "Rep 2. Consistency starts here."
        case 3:
            return "Rep 3. No hesitation."
        default:
            let tips = [
                "You know what to do. Do it.",
                "No second-guessing. Lock in.",
                "Same commitment. New rep.",
                "Pressure makes performance. Use it.",
                "This is the rep that matters.",
            ]
            return tips.randomElement() ?? "Next rep: Commit."
        }
    }
}

struct TipResult {
    let explanation: String
    let tip: String
    let cue: String

    var fullMessage: String {
        "\(explanation)\n\nNext: \(tip)\n\nCue: \(cue)"
    }
}

// MARK: - Accountability Memory

struct AccountabilityEntry: Identifiable, Codable {
    let id: String = UUID().uuidString
    let timestamp: Date
    let sport: Sport
    let trick: String
    let issue: String
    let repCount: Int

    var description: String {
        "Same issue again on \(trick). You said you'd fix this."
    }
}

class AccountabilityMemory: ObservableObject {
    @Published var entries: [AccountabilityEntry] = []

    func recordIssue(_ issue: String, sport: Sport, trick: String, repCount: Int) {
        let entry = AccountabilityEntry(timestamp: Date(), sport: sport, trick: trick, issue: issue, repCount: repCount)
        entries.append(entry)
    }

    func getRecentIssues(sport: Sport, trick: String, limit: Int = 3) -> [AccountabilityEntry] {
        entries.filter { $0.sport == sport && $0.trick == trick }
            .sorted { $0.timestamp > $1.timestamp }
            .prefix(limit)
            .map { $0 }
    }

    func hasRepeatIssue(_ issue: String, sport: Sport) -> Bool {
        let filtered = entries.filter { $0.sport == sport && $0.issue == issue }
        return filtered.count >= 2
    }
}
