//
//  ControlsListTableViewController + Extensions.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 21.01.2024.
//

import UIKit

extension ControlsListTableViewController: ControlsListPresenterDelegate {
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension ControlsListTableViewController {
    func configureCell(cell: UITableViewCell, index: Int)-> UITableViewCell {
        let controlOption = presenter.controlOptionItem(index: index)
        cell.tintColor = .systemGreen
        cell.textLabel?.text = controlOption.title
        cell.textLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        cell.accessoryType = presenter.isControlSelected(index: index) ? .checkmark : .none
        return cell
    }
}
