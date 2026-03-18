import Foundation

enum Sport: String, Codable, CaseIterable, Identifiable {
    case freeskiPark = "Freeski Park"
    case freeskiPipe = "Freeski Pipe"
    case freeskiBigAir = "Freeski Big Air"
    case moguls = "Moguls"
    case aerials = "Aerials"
    case skiRacing = "Ski Racing"
    case bmx = "BMX"
    case trampoline = "Trampoline"

    var id: String { rawValue }

    var displayName: String { rawValue }

    var repName: String {
        switch self {
        case .freeskiPark, .freeskiPipe, .freeskiBigAir:
            return "trick"
        case .moguls, .skiRacing:
            return "run"
        case .aerials:
            return "skill"
        case .bmx:
            return "line"
        case .trampoline:
            return "pass"
        }
    }

    var commonIssues: [String] {
        switch self {
        case .freeskiPark, .freeskiBigAir:
            return ["speed check", "backing off at lip", "late pop", "under-commitment", "incomplete rotation"]
        case .freeskiPipe:
            return ["speed check", "backing off at lip", "weak air grab", "under-commitment", "landing commitment"]
        case .moguls:
            return ["defensive line", "broken rhythm", "late absorption", "hesitation entering line", "tight turns"]
        case .aerials:
            return ["fear of inversion", "weak set", "inconsistent takeoff", "pulling out mid-skill", "poor landing"]
        case .skiRacing:
            return ["defensive skiing", "overcontrol", "late pressure", "hesitation on entry", "tight line"]
        case .bmx:
            return ["pulling out", "freezing mid-line", "not committing to combo", "bailing on spin", "inconsistent takeoff"]
        case .trampoline:
            return ["weak set", "pulling out during inversion", "inconsistent landings", "fear of progression", "tight body position"]
        }
    }

    var cueSamples: [String] {
        switch self {
        case .freeskiPark, .freeskiBigAir:
            return ["commit before the lip", "finish rotation", "no half-send", "trust takeoff", "carry speed"]
        case .freeskiPipe:
            return ["attack the wall", "commit through air", "grab with intention", "spot landing", "no bailout"]
        case .moguls:
            return ["attack the line", "stay centered", "trust rhythm", "move early", "commit through absorption"]
        case .aerials:
            return ["strong set", "commit through takeoff", "eyes up", "finish the skill", "trust the air"]
        case .skiRacing:
            return ["early pressure", "trust the edge", "clean line in", "no defensive turn", "commit to rhythm"]
        case .bmx:
            return ["stay on line", "no bailout", "finish the set", "commit through pop", "land with authority"]
        case .trampoline:
            return ["strong set", "stay tall", "commit through landing", "no pullout", "control entry"]
        }
    }
}
