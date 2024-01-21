//
//  CarColorsListTableViewController + Extensions.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 21.01.2024.
//

import UIKit

extension CarColorsListTableViewController: CarColorsListPresenterDelegate {
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension CarColorsListTableViewController {
    
    func configureCell(cell: UITableViewCell, index: Int)-> UITableViewCell {
        let colorOption = presenter.colorOptionItem(index: index)
        cell.tintColor = presenter.isColorSelected(index: index) ? colorOption.color : .label
        cell.textLabel?.text = colorOption.title
        cell.textLabel?.textColor = presenter.isColorSelected(index: index) ? colorOption.color : .label
        cell.textLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        cell.accessoryType = presenter.isColorSelected(index: index) ? .checkmark : .none
        return cell
    }
}
