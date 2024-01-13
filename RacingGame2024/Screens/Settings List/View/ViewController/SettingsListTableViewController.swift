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
        tableView.register(OptionTableViewCell.self, forCellReuseIdentifier: OptionTableViewCell.identifier)
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
        switch indexPath.row {
        case 1:
            let vc = CarColorsListTableViewController()
            let navVC = UINavigationController(rootViewController: vc)
            present(navVC, animated: true)
        case 2:
            let vc = ObstaclesListTableViewController()
            let navVC = UINavigationController(rootViewController: vc)
            present(navVC, animated: true)
        case 3:
            let vc = LevelOfDifficultyListTableViewController()
            let navVC = UINavigationController(rootViewController: vc)
            present(navVC, animated: true)
        case 4:
            let vc = ControlsListTableViewController()
            let navVC = UINavigationController(rootViewController: vc)
            present(navVC, animated: true)
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Options.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCell.identifier, for: indexPath) as? OptionTableViewCell else {return UITableViewCell()}
        cell.configure(option: Options.allCases[indexPath.row])
        return cell
    }
}