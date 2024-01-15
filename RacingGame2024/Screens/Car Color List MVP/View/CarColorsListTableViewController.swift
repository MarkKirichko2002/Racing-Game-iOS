//
//  CarColorsListTableViewController.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import UIKit

class CarColorsListTableViewController: UITableViewController {

    weak var delegate: OptionsDelegate?
    
    let presenter = CarColorsListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        setUpTable()
        setUpPresenter()
    }
    
    private func setUpNavigation() {
        navigationItem.title = "Выберите цвет"
    }

    private func setUpTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setUpPresenter() {
        presenter.setDelegate(delegate: self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectColor(index: indexPath.row)
        delegate?.optionSelected()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.colorsCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let configuredCell = configureCell(cell: cell, index: indexPath.row)
        return configuredCell
    }
    
    private func configureCell(cell: UITableViewCell, index: Int)-> UITableViewCell {
        let colorOption = presenter.colorOptionItem(index: index)
        cell.tintColor = presenter.isColorSelected(index: index) ? colorOption.color : .label
        cell.textLabel?.text = colorOption.title
        cell.textLabel?.textColor = presenter.isColorSelected(index: index) ? colorOption.color : .label
        cell.textLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        cell.accessoryType = presenter.isColorSelected(index: index) ? .checkmark : .none
        return cell
    }
}

extension CarColorsListTableViewController: CarColorsListPresenterDelegate {
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
