//
//  TeamTableViewCell.swift
//  FlipkartAssignment
//
//  Created by Syed Danish  on 12/08/2026.
//

import UIKit

final class TeamTableViewCell: UITableViewCell {

    @IBOutlet private weak var flagImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!

    func configure(with team: Team, isSelected: Bool) {
        nameLabel.text = team.name
        flagImageView.setFlagImage(from: team.flagURL)
        backgroundColor = isSelected ? .systemGray4 : .systemBackground
    }
}
