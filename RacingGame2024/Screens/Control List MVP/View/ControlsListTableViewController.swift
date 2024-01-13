//
//  ControlsListTableViewController.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import UIKit

class ControlsListTableViewController: UITableViewController {

    private let presenter = ControlsListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        setUpTable()
        setUpPresenter()
    }
    
    private func setUpNavigation() {
        navigationItem.title = "Выберите управление"
    }

    private func setUpTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setUpPresenter() {
        presenter.setDelegate(delegate: self)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectControl(index: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.controlsCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let configuredCell = configureCell(cell: cell, index: indexPath.row)
        return configuredCell
    }
    
    private func configureCell(cell: UITableViewCell, index: Int)-> UITableViewCell {
        let controlOption = presenter.controlOptionItem(index: index)
        cell.tintColor = .systemGreen
        cell.textLabel?.text = controlOption.title
        cell.accessoryType = presenter.isControlSelected(index: index) ? .checkmark : .none
        return cell
    }
}

extension ControlsListTableViewController: ControlsListPresenterDelegate {
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
