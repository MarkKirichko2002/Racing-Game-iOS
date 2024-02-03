//
//  SettingsListTableViewController + Extensions.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 21.01.2024.
//

import UIKit

extension SettingsListTableViewController: SettingsListPresenterDelegate {
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension SettingsListTableViewController: OptionsDelegate {
    
    func optionSelected() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension SettingsListTableViewController {
    
    func showAlert() {
        let alertController = UIAlertController(title: "Изменение данных игрока", message: "Вы хотите точно изменить данные?", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Имя"
        }
        let save = UIAlertAction(title: "Сохранить", style: .default) { _ in
            if let name = alertController.textFields![0].text {
                self.presenter.updatePlayerButtonTapped(name: name)
            }
        }
        let cancel = UIAlertAction(title: "Отмена", style: .destructive)
        alertController.addAction(save)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
}
