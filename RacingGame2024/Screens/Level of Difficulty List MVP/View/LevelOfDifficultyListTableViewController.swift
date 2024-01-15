//
//  LevelOfDifficultyListTableViewController.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import UIKit

class LevelOfDifficultyListTableViewController: UITableViewController {

    weak var delegate: OptionsDelegate?
    
    private let presenter = LevelOfDifficultyListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        setUpTable()
        setUpPresenter()
    }
    
    private func setUpNavigation() {
        navigationItem.title = "Выберите уровень сложности"
    }

    private func setUpTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setUpPresenter() {
        presenter.setDelegate(delegate: self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectlevelOfDifficulty(index: indexPath.row)
        delegate?.optionSelected()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.levelOfDifficultyCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let configuredCell = configureCell(cell: cell, index: indexPath.row)
        return configuredCell
    }
    
    private func configureCell(cell: UITableViewCell, index: Int)-> UITableViewCell {
        let levelOfDifficultyOption = presenter.levelOfDifficultyOptionItem(index: index)
        cell.tintColor = .systemGreen
        cell.textLabel?.text = levelOfDifficultyOption.title
        cell.textLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        cell.accessoryType = presenter.isLevelOfDifficultySelected(index: index) ? .checkmark : .none
        return cell
    }
}

extension LevelOfDifficultyListTableViewController: LevelOfDifficultyListPresenterDelegate {
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
