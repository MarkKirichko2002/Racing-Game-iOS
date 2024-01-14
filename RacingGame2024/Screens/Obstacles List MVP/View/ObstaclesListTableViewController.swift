//
//  ObstaclesListTableViewController.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import UIKit

class ObstaclesListTableViewController: UITableViewController {

    weak var delegate: OptionsDelegate?
    
    let presenter = ObstaclesListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        setUpTable()
        setUpPresenter()
    }
    
    private func setUpNavigation() {
        navigationItem.title = "Выберите препятствие"
    }

    private func setUpTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setUpPresenter() {
        presenter.setDelegate(delegate: self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectObstacle(index: indexPath.row)
        delegate?.optionSelected()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.obstaclesCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let configuredCell = configureCell(cell: cell, index: indexPath.row)
        return configuredCell
    }
    
    private func configureCell(cell: UITableViewCell, index: Int)-> UITableViewCell {
        let obstacleOption = presenter.obstacleOptionItem(index: index)
        cell.tintColor = .systemGreen
        cell.textLabel?.text = obstacleOption.title
        cell.accessoryType = presenter.isObstacleSelected(index: index) ? .checkmark : .none
        return cell
    }
}

extension ObstaclesListTableViewController: ObstaclesListPresenterDelegate {
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
