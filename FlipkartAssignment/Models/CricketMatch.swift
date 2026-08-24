//
//  CricketMatch.swift
//  FlipkartAssignment
//
//  Created by Syed Danish  on 12/08/2026.
//

import Foundation

enum BallOutcome: CaseIterable {
    case dot
    case one
    case two
    case three
    case four
    case six
    case wicket
    case wide
    case noBall

    var runs: Int {
        switch self {
        case .dot: return 0
        case .one: return 1
        case .two: return 2
        case .three: return 3
        case .four: return 4
        case .six: return 6
        case .wicket: return 0
        case .wide: return 1
        case .noBall: return 1
        }
    }

    var isWicket: Bool {
        self == .wicket
    }

    var isLegalDelivery: Bool {
        self != .wide && self != .noBall
    }

    var displayText: String {
        switch self {
        case .dot: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .six: return "6"
        case .wicket: return "Out"
        case .wide: return "Wide"
        case .noBall: return "No Ball"
        }
    }

    private var weight: Int {
        switch self {
        case .dot: return 26
        case .one: return 24
        case .two: return 12
        case .three: return 3
        case .four: return 12
        case .six: return 5
        case .wicket: return 7
        case .wide: return 6
        case .noBall: return 5
        }
    }

    static func random() -> BallOutcome {
        let totalWeight = allCases.reduce(0) { $0 + $1.weight }
        var pick = Int.random(in: 0..<totalWeight)
        for outcome in allCases {
            if pick < outcome.weight {
                return outcome
            }
            pick -= outcome.weight
        }
        return .dot
    }
}

struct Innings {
    let battingTeam: Team
    let bowlingTeam: Team
    private(set) var runs = 0
    private(set) var wickets = 0
    private(set) var ballsBowled = 0

    static let ballsPerOver = 6
    static let maxOvers = 2
    static let maxWickets = 3
    static var maxBalls: Int { maxOvers * ballsPerOver }

    var oversDisplay: String {
        "\(ballsBowled / Self.ballsPerOver).\(ballsBowled % Self.ballsPerOver)"
    }

    var hasEnded: Bool {
        wickets >= Self.maxWickets || ballsBowled >= Self.maxBalls
    }

    mutating func record(_ outcome: BallOutcome) {
        runs += outcome.runs
        if outcome.isWicket {
            wickets += 1
        }
        if outcome.isLegalDelivery {
            ballsBowled += 1
        }
    }
}

final class CricketMatch {

    private(set) var firstInnings: Innings
    private(set) var secondInnings: Innings?

    init(battingFirst: Team, battingSecond: Team) {
        firstInnings = Innings(battingTeam: battingFirst, bowlingTeam: battingSecond)
    }

    var target: Int {
        firstInnings.runs + 1
    }

    var isMatchOver: Bool {
        guard let secondInnings else { return false }
        if secondInnings.runs >= target { return true }
        return secondInnings.hasEnded
    }

    var resultText: String {
        guard let secondInnings else { return "" }
        if secondInnings.runs > firstInnings.runs {
            return "\(secondInnings.battingTeam.name) Wins"
        }
        if secondInnings.runs == firstInnings.runs {
            return "Match Tied"
        }
        return "\(firstInnings.battingTeam.name) Wins"
    }

    @discardableResult
    func playNextBall() -> BallOutcome {
        let outcome = BallOutcome.random()

        if var secondInnings {
            secondInnings.record(outcome)
            self.secondInnings = secondInnings
        } else {
            firstInnings.record(outcome)
            if firstInnings.hasEnded {
                secondInnings = Innings(battingTeam: firstInnings.bowlingTeam, bowlingTeam: firstInnings.battingTeam)
            }
        }

        return outcome
    }
}
