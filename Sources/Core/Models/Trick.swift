import Foundation

struct Trick: Identifiable, Codable {
    let id: String
    let name: String
    let sport: Sport
    let category: String
    let description: String
    let howToCue: String
    let commonFailure: String
    let mentalBlock: String
    let progressionLevel: ProgressionLevel

    enum ProgressionLevel: String, Codable {
        case beginner, intermediate, advanced, elite
    }
}

// MARK: - Seed Data

let trickLibraryData: [Trick] = [
    // FREESKI PARK
    Trick(id: "1001", name: "180", sport: .freeskiPark, category: "Spins",
          description: "Half rotation in air, landing switch",
          howToCue: "Pop and rotate early",
          commonFailure: "Under-rotation, landing sideways",
          mentalBlock: "Hesitation leaving the jump",
          progressionLevel: .beginner),

    Trick(id: "1002", name: "360", sport: .freeskiPark, category: "Spins",
          description: "Full rotation in air, landing forward",
          howToCue: "Pop hard, commit rotation early",
          commonFailure: "Under-rotation, backing out",
          mentalBlock: "Fear of overspin",
          progressionLevel: .intermediate),

    Trick(id: "1003", name: "540", sport: .freeskiPark, category: "Spins",
          description: "One and a half rotations",
          howToCue: "Explosive pop, spot landing early",
          commonFailure: "Losing sight of landing",
          mentalBlock: "Loss of orientation",
          progressionLevel: .advanced),

    Trick(id: "1004", name: "720", sport: .freeskiPark, category: "Spins",
          description: "Two full rotations",
          howToCue: "Commit through the second spin",
          commonFailure: "Under-rotation on second rotation",
          mentalBlock: "Commitment through spin",
          progressionLevel: .advanced),

    Trick(id: "1005", name: "Cork 7", sport: .freeskiPark, category: "Inverted",
          description: "Flip into 180 rotation",
          howToCue: "Drive knees up, spot the cork",
          commonFailure: "Weak launch, poor flip entry",
          mentalBlock: "Fear of inversion",
          progressionLevel: .intermediate),

    Trick(id: "1006", name: "Backflip", sport: .freeskiPark, category: "Inverted",
          description: "Full rotation backwards",
          howToCue: "Pop straight up, tuck knees",
          commonFailure: "Under-rotation, late flip",
          mentalBlock: "Loss of reference",
          progressionLevel: .intermediate),

    Trick(id: "1007", name: "Double Flip", sport: .freeskiPark, category: "Inverted",
          description: "Two backward rotations",
          howToCue: "Tight tuck, spot twice",
          commonFailure: "Opening up early",
          mentalBlock: "Dizzy commitment",
          progressionLevel: .advanced),

    Trick(id: "1008", name: "Mute Grab", sport: .freeskiPark, category: "Grabs",
          description: "Grab toe edge between bindings",
          howToCue: "Lead with grab intention",
          commonFailure: "Weak grab, arms pulled back",
          mentalBlock: "Style hesitation",
          progressionLevel: .beginner),

    Trick(id: "1009", name: "Indy Grab", sport: .freeskiPark, category: "Grabs",
          description: "Grab heel edge between bindings",
          howToCue: "Reach down with intention",
          commonFailure: "Off-balance grab",
          mentalBlock: "Body position fear",
          progressionLevel: .beginner),

    Trick(id: "1010", name: "Tail", sport: .freeskiPark, category: "Grabs",
          description: "Grab ski tail with both hands",
          howToCue: "Extend and grab high",
          commonFailure: "Letting go early",
          mentalBlock: "Loss of control feel",
          progressionLevel: .intermediate),

    // FREESKI PIPE
    Trick(id: "2001", name: "Air to Fakie", sport: .freeskiPipe, category: "Airs",
          description: "Launch into air, land fakie going back",
          howToCue: "Commit through the air rotation",
          commonFailure: "Landing flat, backing down wall",
          mentalBlock: "Wall commitment",
          progressionLevel: .beginner),

    Trick(id: "2002", name: "540 Air", sport: .freeskiPipe, category: "Airs",
          description: "One and half rotations on the wall",
          howToCue: "Spot the landing early",
          commonFailure: "Losing pipe sight",
          mentalBlock: "Height hesitation",
          progressionLevel: .intermediate),

    Trick(id: "2003", name: "Invert", sport: .freeskiPipe, category: "Inverted",
          description: "Flipping upside down on the pipe",
          howToCue: "Drive knees to wall",
          commonFailure: "Weak launch into invert",
          mentalBlock: "Fear of upside down",
          progressionLevel: .intermediate),

    Trick(id: "2004", name: "McTwist", sport: .freeskiPipe, category: "Inverted",
          description: "Flip with 540 rotation",
          howToCue: "Commit through full rotation",
          commonFailure: "Under-rotation, weak entry",
          mentalBlock: "Complex movement fear",
          progressionLevel: .advanced),

    Trick(id: "2005", name: "Tweaked Grab", sport: .freeskiPipe, category: "Grabs",
          description: "Grab and tweaked body position",
          howToCue: "Hold grab with style through air",
          commonFailure: "Letting go for balance",
          mentalBlock: "Style commitment",
          progressionLevel: .intermediate),

    // FREESKI BIG AIR
    Trick(id: "3001", name: "Switch 7", sport: .freeskiBigAir, category: "Spins",
          description: "Backward approach, 1.75 rotation",
          howToCue: "Trust backward approach",
          commonFailure: "Hesitating on switch approach",
          mentalBlock: "Direction reversal",
          progressionLevel: .advanced),

    Trick(id: "3002", name: "Double Cork", sport: .freeskiBigAir, category: "Inverted",
          description: "Two flips with rotation",
          howToCue: "Commit through both flips",
          commonFailure: "Opening too early",
          mentalBlock: "Over-rotation fear",
          progressionLevel: .elite),

    Trick(id: "3003", name: "1080 Grab", sport: .freeskiBigAir, category: "Spins",
          description: "Three full rotations with grab",
          howToCue: "Maintain grab through rotation",
          commonFailure: "Losing balance mid-rotation",
          mentalBlock: "Spin commitment",
          progressionLevel: .advanced),

    Trick(id: "3004", name: "Backflip 540", sport: .freeskiBigAir, category: "Inverted",
          description: "Flip with 540 rotation combo",
          howToCue: "Spot landing through flip",
          commonFailure: "Losing reference mid-skill",
          mentalBlock: "Spatial disorientation",
          progressionLevel: .elite),

    // MOGULS
    Trick(id: "4001", name: "Mogul Rhythm", sport: .moguls, category: "Line Work",
          description: "Consistent absorption through mogul field",
          howToCue: "Attack each bump, stay centered",
          commonFailure: "Defensive line, tight rhythm",
          mentalBlock: "Trust the rhythm",
          progressionLevel: .intermediate),

    Trick(id: "4002", name: "Mogul Air", sport: .moguls, category: "Airs",
          description: "Launch off mogul with trick",
          howToCue: "Pop the mogul with intention",
          commonFailure: "Weak pop, no air height",
          mentalBlock: "Adding air to rhythm",
          progressionLevel: .intermediate),

    Trick(id: "4003", name: "Zipper Line", sport: .moguls, category: "Line Work",
          description: "Tight line through mogul crests",
          howToCue: "Commit to tight line",
          commonFailure: "Drifting wide on moguls",
          mentalBlock: "Tight control commitment",
          progressionLevel: .advanced),

    // AERIALS
    Trick(id: "5001", name: "Back Tuck", sport: .aerials, category: "Inverted",
          description: "Backward flip with tight body position",
          howToCue: "Tight tuck from takeoff",
          commonFailure: "Opening up too early",
          mentalBlock: "Inversion fear",
          progressionLevel: .beginner),

    Trick(id: "5002", name: "Back Full", sport: .aerials, category: "Inverted",
          description: "Back flip with full twist",
          howToCue: "Commit twist through flip",
          commonFailure: "Under-rotation",
          mentalBlock: "Rotation complexity",
          progressionLevel: .intermediate),

    Trick(id: "5003", name: "Barani", sport: .aerials, category: "Inverted",
          description: "Front flip with half twist",
          howToCue: "Strong set, commit twist",
          commonFailure: "Weak set, poor twist entry",
          mentalBlock: "Forward inversion",
          progressionLevel: .intermediate),

    Trick(id: "5004", name: "Double Back", sport: .aerials, category: "Inverted",
          description: "Two backward flips",
          howToCue: "Tight tuck throughout",
          commonFailure: "Opening between flips",
          mentalBlock: "Rotation commitment",
          progressionLevel: .advanced),

    // SKI RACING
    Trick(id: "6001", name: "Gate Entry", sport: .skiRacing, category: "Technique",
          description: "Clean approach and turn into slalom gate",
          howToCue: "Early pressure, trust the edge",
          commonFailure: "Late pressure, defensive approach",
          mentalBlock: "Line commitment",
          progressionLevel: .beginner),

    Trick(id: "6002", name: "GS Line", sport: .skiRacing, category: "Technique",
          description: "Wide radius turn on giant slalom",
          howToCue: "Commit to aggressive radius",
          commonFailure: "Cutting line short, going defensive",
          mentalBlock: "Speed management",
          progressionLevel: .intermediate),

    Trick(id: "6003", name: "Rhythm Gate Set", sport: .skiRacing, category: "Technique",
          description: "Quick consecutive gates in rhythm",
          howToCue: "No hesitation between gates",
          commonFailure: "Hesitation, broken rhythm",
          mentalBlock: "Pace maintenance",
          progressionLevel: .advanced),

    // BMX
    Trick(id: "7001", name: "BMX 360", sport: .bmx, category: "Spins",
          description: "Full rotation on the bike",
          howToCue: "Pop and commit rotation",
          commonFailure: "Under-rotation, bailing",
          mentalBlock: "Spin commitment",
          progressionLevel: .intermediate),

    Trick(id: "7002", name: "Tailwhip", sport: .bmx, category: "Tricks",
          description: "Whip frame under feet, catch with feet",
          howToCue: "Quick whip and catch",
          commonFailure: "Losing bike position",
          mentalBlock: "Timing precision",
          progressionLevel: .intermediate),

    Trick(id: "7003", name: "360 Tailwhip", sport: .bmx, category: "Combos",
          description: "360 rotation plus tailwhip combo",
          howToCue: "Commit both tricks through",
          commonFailure: "Incomplete rotation plus whip",
          mentalBlock: "Combo commitment",
          progressionLevel: .advanced),

    Trick(id: "7004", name: "Flair", sport: .bmx, category: "Inverted",
          description: "Backflip with 180 on ramp",
          howToCue: "Drive flip through rotation",
          commonFailure: "Weak pop, under-rotation",
          mentalBlock: "Ramp inversion",
          progressionLevel: .advanced),

    // TRAMPOLINE
    Trick(id: "8001", name: "Back Tuck", sport: .trampoline, category: "Skills",
          description: "Backward flip with tight body",
          howToCue: "Tight tuck from takeoff",
          commonFailure: "Opening too early",
          mentalBlock: "Inversion anxiety",
          progressionLevel: .beginner),

    Trick(id: "8002", name: "Back Full", sport: .trampoline, category: "Skills",
          description: "Back flip plus full twist",
          howToCue: "Stay tall, commit twist",
          commonFailure: "Under-rotation",
          mentalBlock: "Rotation timing",
          progressionLevel: .intermediate),

    Trick(id: "8003", name: "Double Back", sport: .trampoline, category: "Skills",
          description: "Two consecutive backflips",
          howToCue: "Consistent height, tight tuck",
          commonFailure: "Inconsistent bounce",
          mentalBlock: "Repetition consistency",
          progressionLevel: .advanced),
]
