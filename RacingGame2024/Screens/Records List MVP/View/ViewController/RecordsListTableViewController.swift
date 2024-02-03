//
//  RecordsListTableViewController.swift
//  RacingGame
//
//  Created by Марк Киричко on 12.01.2024.
//

import UIKit

class RecordsListTableViewController: UITableViewController {

    private let presenter = RecordsListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        setUpNavigation()
        setUpPresenter()
    }
    
    private func setUpTable() {
        tableView.rowHeight = Constants.rowHeight
        tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: PlayerTableViewCell.identifier)
    }
    
    private func setUpNavigation() {
        navigationItem.title = Constants.recordsTitle
        let closeButton = UIBarButtonItem(image: UIImage(named: Constants.cross), style: .done, target: self, action: #selector(closeScreen))
        closeButton.tintColor = .label
        navigationItem.rightBarButtonItem = closeButton
    }
    
    private func setUpPresenter() {
        presenter.setDelegate(delegate: self)
        presenter.getResults()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteResult(result: presenter.results[indexPath.row])
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayerTableViewCell.identifier, for: indexPath) as? PlayerTableViewCell else {return UITableViewCell()}
        cell.configure(result: presenter.results[indexPath.row])
        return cell
    }
}
