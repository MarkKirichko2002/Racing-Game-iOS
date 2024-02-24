//
//  RecordsListTableViewController + Extensions.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 22.01.2024.
//

import UIKit

// MARK: - RecordsListPresenterDelegate
extension RecordsListTableViewController: RecordsListPresenterDelegate {
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
