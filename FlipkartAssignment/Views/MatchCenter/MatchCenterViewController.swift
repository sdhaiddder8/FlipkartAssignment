//
//  MatchCenterViewController.swift
//  FlipkartAssignment
//
//  Created by Syed Danish  on 12/08/2026.
//

import UIKit

final class MatchCenterViewController: UIViewController {

    @IBOutlet private weak var team1NameLabel: UILabel!
    @IBOutlet private weak var team1ScoreLabel: UILabel!
    @IBOutlet private weak var team1OversLabel: UILabel!
    @IBOutlet private weak var team2NameLabel: UILabel!
    @IBOutlet private weak var team2ScoreLabel: UILabel!
    @IBOutlet private weak var team2OversLabel: UILabel!
    @IBOutlet private weak var outcomeLabel: UILabel!
    @IBOutlet private weak var playNextBallButton: UIButton!

    private let viewModel: MatchCenterViewModel

    init(viewModel: MatchCenterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MatchCenterViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Match Center"
        refreshScoreboard()
    }

    @IBAction private func playNextBallButtonTapped(_ sender: UIButton) {
        outcomeLabel.text = viewModel.playNextBall()
        refreshScoreboard()

        if viewModel.isMatchOver {
            playNextBallButton.setTitle("Match Over", for: .normal)
            playNextBallButton.isEnabled = false
        }
    }

    private func refreshScoreboard() {
        team1NameLabel.text = viewModel.team1Title
        team1ScoreLabel.text = viewModel.team1ScoreText
        team1OversLabel.text = viewModel.team1OversText
        team2NameLabel.text = viewModel.team2Title
        team2ScoreLabel.text = viewModel.team2ScoreText
        team2OversLabel.text = viewModel.team2OversText
    }
}
