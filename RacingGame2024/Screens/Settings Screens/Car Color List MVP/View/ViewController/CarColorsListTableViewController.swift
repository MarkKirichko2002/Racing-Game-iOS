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
        let closeButton = UIBarButtonItem(image: UIImage(named: "cross"), style: .done, target: self, action: #selector(closeScreen))
        closeButton.tintColor = .label
        navigationItem.rightBarButtonItem = closeButton
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
}