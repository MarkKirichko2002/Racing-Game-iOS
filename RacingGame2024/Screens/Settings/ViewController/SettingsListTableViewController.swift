//
//  SettingsListTableViewController.swift
//  RacingGame
//
//  Created by Марк Киричко on 12.01.2024.
//

import UIKit

class SettingsListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        setUpNavigation()
    }
    
    private func setUpTable() {
        tableView.rowHeight = 100
        tableView.register(PlayerOptionTableViewCell.self, forCellReuseIdentifier: PlayerOptionTableViewCell.identifier)
        tableView.register(CarColorOptionTableViewCell.self, forCellReuseIdentifier: CarColorOptionTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "obstacleOptionCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "hardOptionCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "controlOptionCell")
    }
    
    private func setUpNavigation() {
        navigationItem.title = "Настройки ⚙️"
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeScreen))
        closeButton.tintColor = .label
        navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc private func closeScreen() {
        dismiss(animated: true)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayerOptionTableViewCell.identifier, for: indexPath) as? PlayerOptionTableViewCell else {return UITableViewCell()}
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CarColorOptionTableViewCell.identifier, for: indexPath) as? CarColorOptionTableViewCell else {return UITableViewCell()}
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "obstacleOptionCell", for: indexPath)
            cell.textLabel?.text = "Препятствия"
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "hardOptionCell", for: indexPath)
            cell.textLabel?.text = "Сложность"
            
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "controlOptionCell", for: indexPath)
            cell.textLabel?.text = "Управление"
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
