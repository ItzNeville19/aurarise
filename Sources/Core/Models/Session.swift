import Foundation

struct Session: Identifiable, Codable {
    let id: String
    let date: Date
    let sport: Sport
    let activeTrick: String
    var reps: [Rep]
    var isActive: Bool

    init(sport: Sport, activeTrick: String) {
        self.id = UUID().uuidString
        self.date = Date()
        self.sport = sport
        self.activeTrick = activeTrick
        self.reps = []
        self.isActive = true
    }

    var repCount: Int { reps.count }

    var successCount: Int { reps.filter { $0.outcome == .success }.count }

    var successRate: Double {
        guard !reps.isEmpty else { return 0 }
        return Double(successCount) / Double(reps.count)
    }

    mutating func addRep(_ rep: Rep) {
        reps.append(rep)
    }

    mutating func endSession() {
        isActive = false
    }
}

struct Rep: Identifiable, Codable {
    let id: String
    let timestamp: Date
    let commitment: Bool
    let outcome: RepOutcome
    let note: String?
    let issueTag: String?

    init(commitment: Bool, outcome: RepOutcome, note: String? = nil, issueTag: String? = nil) {
        self.id = UUID().uuidString
        self.timestamp = Date()
        self.commitment = commitment
        self.outcome = outcome
        self.note = note
        self.issueTag = issueTag
    }
}

enum RepOutcome: String, Codable, CaseIterable {
    case success = "success"
    case bail = "bail"
    case miss = "miss"
    case partial = "partial"
    case fail = "fail"

    var displayName: String {
        switch self {
        case .success: return "Sent"
        case .bail: return "Bailed"
        case .miss: return "Missed"
        case .partial: return "Partial"
        case .fail: return "Failed"
        }
    }

    var emoji: String {
        switch self {
        case .success: return "✓"
        case .bail: return "✗"
        case .miss: return "–"
        case .partial: return "~"
        case .fail: return "!"
        }
    }
}
