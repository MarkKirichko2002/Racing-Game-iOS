//
//  ObstaclesListTableViewController + Extensions.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 21.01.2024.
//

import UIKit

extension ObstaclesListTableViewController: ObstaclesListPresenterDelegate {
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension ObstaclesListTableViewController {
    func configureCell(cell: UITableViewCell, index: Int)-> UITableViewCell {
        let obstacleOption = presenter.obstacleOptionItem(index: index)
        cell.tintColor = .systemGreen
        cell.textLabel?.text = obstacleOption.title
        cell.textLabel?.font = .systemFont(ofSize: Constants.fontSize, weight: Constants.fontWeight)
        cell.accessoryType = presenter.isObstacleSelected(index: index) ? .checkmark : .none
        return cell
    }
}
