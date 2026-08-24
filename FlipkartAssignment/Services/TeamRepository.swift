//
//  TeamRepository.swift
//  FlipkartAssignment
//
//  Created by Syed Danish  on 12/08/2026.
//

import Foundation

protocol TeamRepository {
    func fetchTeams() -> [Team]
}

final class LocalTeamRepository: TeamRepository {

    func fetchTeams() -> [Team] {
        guard
            let url = Bundle.main.url(forResource: "teams", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let teams = try? JSONDecoder().decode([Team].self, from: data)
        else {
            return []
        }
        return teams
    }
}
