//
//  ObstaclesListTableViewController.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import UIKit

private extension String {
    static let title = "Выберите препятствие"
    static let identifier = "obstaclesListCell"
}

final class ObstaclesListTableViewController: UITableViewController {

    weak var delegate: OptionsDelegate?
    
    var presenter: IObstaclesListPresenter
    
    init(presenter: IObstaclesListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        setUpTable()
        setUpPresenter()
    }
    
    private func setUpNavigation() {
        navigationItem.title = String.title
        let closeButton = UIBarButtonItem(image: UIImage(named: Constants.cross), style: .done, target: self, action: #selector(closeScreen))
        closeButton.tintColor = .label
        navigationItem.rightBarButtonItem = closeButton
    }
    
    private func setUpTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String.identifier)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: String.identifier, for: indexPath)
        let configuredCell = configureCell(cell: cell, index: indexPath.row)
        return configuredCell
    }
}
