//
//  Team.swift
//  FlipkartAssignment
//
//  Created by Syed Danish  on 12/08/2026.
//

import Foundation

struct Team: Decodable, Equatable {
    let name: String
    let flag: String

    var flagURL: URL? {
        URL(string: flag)
    }
}
