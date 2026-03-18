import Foundation
import Combine

@MainActor
class AppState: ObservableObject {
    @Published var selectedSport: Sport = .freeskiPark
    @Published var activeTrick: String = ""
    @Published var currentSession: Session?
    @Published var sessionHistory: [Session] = []
    @Published var allTricks: [Trick] = trickLibraryData
    @Published var commitStreak: Int = 0
    @Published var successStreak: Int = 0
    @Published var lastCommitDate: Date?

    @Published var isPremium: Bool = false
    @Published var hasSeenOnboarding: Bool = false

    // MARK: - Initialization

    init() {
        loadData()
    }

    // MARK: - Session Management

    func startSession(with trick: String) {
        let session = Session(sport: selectedSport, activeTrick: trick)
        self.currentSession = session
        self.activeTrick = trick
    }

    func addRep(commitment: Bool, outcome: RepOutcome, note: String? = nil, issueTag: String? = nil) {
        guard var session = currentSession else { return }
        let rep = Rep(commitment: commitment, outcome: outcome, note: note, issueTag: issueTag)
        session.addRep(rep)
        self.currentSession = session

        // Update streaks
        updateStreaks(outcome: outcome, committed: commitment)
    }

    func endSession() {
        guard var session = currentSession else { return }
        session.endSession()
        sessionHistory.append(session)
        currentSession = nil
        saveData()
    }

    // MARK: - Streaks & Progress

    func updateStreaks(outcome: RepOutcome, committed: Bool) {
        if committed {
            commitStreak += 1
            lastCommitDate = Date()
        } else {
            commitStreak = 0
        }

        if outcome == .success {
            successStreak += 1
        } else {
            successStreak = 0
        }

        saveData()
    }

    func commitmentRate() -> Double {
        guard !sessionHistory.isEmpty else { return 0 }
        let totalReps = sessionHistory.flatMap { $0.reps }.count
        let committedReps = sessionHistory.flatMap { $0.reps }.filter { $0.commitment }.count
        return totalReps > 0 ? Double(committedReps) / Double(totalReps) : 0
    }

    func successRate() -> Double {
        guard !sessionHistory.isEmpty else { return 0 }
        let totalReps = sessionHistory.flatMap { $0.reps }.count
        let successReps = sessionHistory.flatMap { $0.reps }.filter { $0.outcome == .success }.count
        return totalReps > 0 ? Double(successReps) / Double(totalReps) : 0
    }

    func consistencyScore() -> Int {
        let commitRate = commitmentRate()
        let successRate = successRate()
        let avg = (commitRate + successRate) / 2
        return Int(avg * 100)
    }

    // MARK: - Trick Library

    func tricksForSport(_ sport: Sport) -> [Trick] {
        allTricks.filter { $0.sport == sport }
    }

    func searchTricks(_ query: String) -> [Trick] {
        guard !query.isEmpty else { return allTricks }
        return allTricks.filter { trick in
            trick.name.localizedCaseInsensitiveContains(query) ||
                trick.description.localizedCaseInsensitiveContains(query) ||
                trick.category.localizedCaseInsensitiveContains(query)
        }
    }

    // MARK: - Data Persistence

    private func saveData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(sessionHistory) {
            UserDefaults.standard.set(encoded, forKey: "sessionHistory")
        }
        UserDefaults.standard.set(commitStreak, forKey: "commitStreak")
        UserDefaults.standard.set(lastCommitDate, forKey: "lastCommitDate")
    }

    private func loadData() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "sessionHistory"),
           let decoded = try? decoder.decode([Session].self, from: data) {
            sessionHistory = decoded
        }

        commitStreak = UserDefaults.standard.integer(forKey: "commitStreak")
        lastCommitDate = UserDefaults.standard.object(forKey: "lastCommitDate") as? Date
        hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
    }
}
