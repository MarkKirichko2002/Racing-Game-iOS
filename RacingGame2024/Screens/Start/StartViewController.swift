//
//  StartViewController.swift
//  RacingGame
//
//  Created by Марк Киричко on 11.01.2024.
//

import UIKit

class StartViewController: UIViewController {

    // MARK: - UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Гонки 2024"
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let StartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начать игру 🏎️", for: .normal)
        button.setTitleColor(UIColor.systemGreen, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let SettingsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Настройки ⚙️", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let RecordsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Рекорды 🏆", for: .normal)
        button.setTitleColor(UIColor.systemYellow, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        makeConstraints()
    }
    
    // MARK: - Flow funcs
    private func setUpView() {
        view.backgroundColor = .systemBackground
        view.addSubviews(views: titleLabel, StartButton, SettingsButton, RecordsButton)
        StartButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        SettingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        RecordsButton.addTarget(self, action: #selector(openRecords), for: .touchUpInside)
    }
    
    private func makeConstraints() {
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            StartButton.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 135),
            StartButton.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            
            SettingsButton.topAnchor.constraint(equalTo: StartButton.topAnchor, constant: 85),
            SettingsButton.centerXAnchor.constraint(equalTo: StartButton.centerXAnchor),
            
            RecordsButton.topAnchor.constraint(equalTo: SettingsButton.topAnchor, constant: 85),
            RecordsButton.centerXAnchor.constraint(equalTo: SettingsButton.centerXAnchor),
        ])
    }
    
    @objc private func startGame() {
        let vc = GameViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc private func openSettings() {
        let vc = SettingsListTableViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    @objc private func openRecords() {
        let vc = RecordsListTableViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}
