//
//  TeamsListViewModel.swift
//  FlipkartAssignment
//
//  Created by Syed Danish  on 12/08/2026.
//

import Foundation

final class TeamsListViewModel {

    private let teamRepository: TeamRepository
    private(set) var teams: [Team] = []
    private(set) var selectedTeams: [Team] = []

    init(teamRepository: TeamRepository = LocalTeamRepository()) {
        self.teamRepository = teamRepository
        teams = teamRepository.fetchTeams()
    }

    var numberOfTeams: Int {
        teams.count
    }

    var isReadyToStartMatch: Bool {
        selectedTeams.count == 2
    }

    func team(at index: Int) -> Team {
        teams[index]
    }

    func isTeamSelected(_ team: Team) -> Bool {
        selectedTeams.contains(team)
    }

    @discardableResult
    func toggleSelection(at index: Int) -> [Int] {
        let team = teams[index]
        var changedIndexes = [index]

        if let existingIndex = selectedTeams.firstIndex(of: team) {
            selectedTeams.remove(at: existingIndex)
        } else if selectedTeams.count < 2 {
            selectedTeams.append(team)
        } else {
            let bumpedTeam = selectedTeams.removeFirst()
            selectedTeams.append(team)
            if let bumpedIndex = teams.firstIndex(of: bumpedTeam) {
                changedIndexes.append(bumpedIndex)
            }
        }

        return changedIndexes
    }

    func makeMatchCenterViewModel() -> MatchCenterViewModel? {
        guard selectedTeams.count == 2 else { return nil }
        return MatchCenterViewModel(teamA: selectedTeams[0], teamB: selectedTeams[1])
    }
}
