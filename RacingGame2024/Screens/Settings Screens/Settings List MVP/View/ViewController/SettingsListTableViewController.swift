//
//  SettingsListTableViewController.swift
//  RacingGame
//
//  Created by Марк Киричко on 12.01.2024.
//

import UIKit

final class SettingsListTableViewController: UITableViewController {

    var presenter: ISettingsListPresenter
    
    init(presenter: ISettingsListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        setUpNavigation()
        setUpPresenter()
    }
    
    private func setUpTable() {
        tableView.rowHeight = Constants.rowHeight
        tableView.register(OptionTableViewCell.self, forCellReuseIdentifier: OptionTableViewCell.identifier)
    }
    
    private func setUpNavigation() {
        navigationItem.title = Constants.settingsTitle
        let closeButton = UIBarButtonItem(image: UIImage(named: Constants.cross), style: .done, target: self, action: #selector(closeScreen))
        closeButton.tintColor = .label
        navigationItem.rightBarButtonItem = closeButton
    }
    
    private func setUpPresenter() {
        presenter.setDelegate(delegate: self)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            showAlert()
        case 1:
            guard let vc = ScreensFactory.createScreen(screen: .carColorsList) as? CarColorsListTableViewController else {return}
            vc.delegate = self
            let navVC = UINavigationController(rootViewController: vc)
            present(navVC, animated: true)
        case 2:
            guard let vc = ScreensFactory.createScreen(screen: .obstaclesList) as? ObstaclesListTableViewController else {return}
            vc.delegate = self
            let navVC = UINavigationController(rootViewController: vc)
            present(navVC, animated: true)
        case 3:
            guard let vc = ScreensFactory.createScreen(screen: .levelOfDifficultyList) as? LevelOfDifficultyListTableViewController else {return}
            vc.delegate = self
            let navVC = UINavigationController(rootViewController: vc)
            present(navVC, animated: true)
        case 4:
            guard let vc = ScreensFactory.createScreen(screen: .controlsList) as? ControlsListTableViewController else {return}
            vc.delegate = self
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
        let option = Options.allCases[indexPath.row]
        if option == .playerInfo {
            cell.configureProfileCell(profile: presenter.getProfileInfo())
        } else {
            cell.configure(option: option, info: presenter.getInfoForOption(option: option))
        }
        return cell
    }
}
