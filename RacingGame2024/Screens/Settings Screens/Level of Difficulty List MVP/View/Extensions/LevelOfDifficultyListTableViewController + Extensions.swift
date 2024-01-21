//
//  LevelOfDifficultyListTableViewController + Extensions.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 21.01.2024.
//

import UIKit

extension LevelOfDifficultyListTableViewController: LevelOfDifficultyListPresenterDelegate {
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension LevelOfDifficultyListTableViewController {
    
    func configureCell(cell: UITableViewCell, index: Int)-> UITableViewCell {
        let levelOfDifficultyOption = presenter.levelOfDifficultyOptionItem(index: index)
        cell.tintColor = .systemGreen
        cell.textLabel?.text = levelOfDifficultyOption.title
        cell.textLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        cell.accessoryType = presenter.isLevelOfDifficultySelected(index: index) ? .checkmark : .none
        return cell
    }
}
