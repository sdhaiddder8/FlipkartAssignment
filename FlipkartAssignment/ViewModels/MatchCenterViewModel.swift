//
//  MatchCenterViewModel.swift
//  FlipkartAssignment
//
//  Created by Syed Danish  on 12/08/2026.
//

import Foundation

final class MatchCenterViewModel {

    private let match: CricketMatch

    init(teamA: Team, teamB: Team) {
        match = CricketMatch(battingFirst: teamA, battingSecond: teamB)
    }

    private var firstInningsInProgress: Bool {
        match.secondInnings == nil
    }

    var team1Title: String {
        "\(match.firstInnings.battingTeam.name) (\(firstInningsInProgress ? "Batting" : "Bowling"))"
    }

    var team1ScoreText: String {
        "Score: \(match.firstInnings.runs)/\(match.firstInnings.wickets)"
    }

    var team1OversText: String {
        "Overs: \(match.firstInnings.oversDisplay)"
    }

    var team2Title: String {
        "\(match.firstInnings.bowlingTeam.name) (\(firstInningsInProgress ? "Bowling" : "Batting"))"
    }

    var team2ScoreText: String {
        guard let secondInnings = match.secondInnings else { return "yet to bat" }
        return "Score: \(secondInnings.runs)/\(secondInnings.wickets)"
    }

    var team2OversText: String {
        guard let secondInnings = match.secondInnings else { return "yet to bat" }
        return "Overs: \(secondInnings.oversDisplay)"
    }

    var isMatchOver: Bool {
        match.isMatchOver
    }

    @discardableResult
    func playNextBall() -> String {
        let outcome = match.playNextBall()
        return isMatchOver ? match.resultText : outcome.displayText
    }
}
