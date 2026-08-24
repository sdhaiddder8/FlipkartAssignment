//
//  TeamsListViewController.swift
//  FlipkartAssignment
//
//  Created by Syed Danish  on 12/08/2026.
//

import UIKit

final class TeamsListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var startMatchButton: UIButton!

    private let viewModel = TeamsListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Teams"

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "TeamCell")

        updateStartMatchButton()
    }

    @IBAction private func startMatchButtonTapped(_ sender: UIButton) {
        guard let matchCenterViewModel = viewModel.makeMatchCenterViewModel() else { return }
        let matchCenter = MatchCenterViewController(viewModel: matchCenterViewModel)
        navigationController?.pushViewController(matchCenter, animated: true)
    }

    private func updateStartMatchButton() {
        startMatchButton.isEnabled = viewModel.isReadyToStartMatch
        startMatchButton.backgroundColor = viewModel.isReadyToStartMatch ? .systemGreen : .systemGray3
    }
}

extension TeamsListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfTeams
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as? TeamTableViewCell else {
            return UITableViewCell()
        }
        let team = viewModel.team(at: indexPath.row)
        cell.configure(with: team, isSelected: viewModel.isTeamSelected(team))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        56
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let changedIndexes = viewModel.toggleSelection(at: indexPath.row)
        tableView.reloadRows(at: changedIndexes.map { IndexPath(row: $0, section: 0) }, with: .none)
        updateStartMatchButton()
    }
}
