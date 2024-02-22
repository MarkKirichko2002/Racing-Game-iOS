//
//  StartViewController.swift
//  RacingGame
//
//  Created by Марк Киричко on 11.01.2024.
//

import UIKit

private extension String {
    static let start: Self = "Начать игру 🏎️"
}

private extension TimeInterval {
    static let interval: Self = 0.1
}

private extension CGFloat {
    static let titleFontSize: Self = 23
    static let fontSize: Self = 18
    static let titleLabelTop: Self = 100
    static let startButtonTop: Self = 135
    static let settingsButtonTop: Self = 85
    static let recordsButtonTop: Self = 85
    static let x: Self = 0
    static let y: Self = 100
}

class StartViewController: UIViewController {

    // MARK: - UI
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = false
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.title
        label.textColor = .white
        label.font = .systemFont(ofSize: CGFloat.titleFontSize, weight: Constants.fontWeight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let StartButton: UIButton = {
        let button = UIButton()
        button.setTitle(String.start, for: .normal)
        button.setTitleColor(UIColor.systemGreen, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat.fontSize, weight: Constants.fontWeight)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let SettingsButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.settingsTitle, for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat.fontSize, weight: Constants.fontWeight)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let RecordsButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.recordsTitle, for: .normal)
        button.setTitleColor(UIColor.systemYellow, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: CGFloat.fontSize, weight: Constants.fontWeight)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // vars/lets
    private var timer: Timer?
    
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        makeConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollBackground()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }
    
    // MARK: - Flow funcs
    private func setUpView() {
        view.addSubview(scrollView)
        scrollView.frame = view.bounds
        scrollView.backgroundColor = UIColor(patternImage: Constants.background)
        view.addSubviews(views: titleLabel, StartButton, SettingsButton, RecordsButton)
        StartButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        SettingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        RecordsButton.addTarget(self, action: #selector(openRecords), for: .touchUpInside)
    }
    
    private func makeConstraints() {
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat.titleLabelTop),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            StartButton.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: CGFloat.startButtonTop),
            StartButton.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            
            SettingsButton.topAnchor.constraint(equalTo: StartButton.topAnchor, constant: CGFloat.settingsButtonTop),
            SettingsButton.centerXAnchor.constraint(equalTo: StartButton.centerXAnchor),
            
            RecordsButton.topAnchor.constraint(equalTo: SettingsButton.topAnchor, constant: CGFloat.recordsButtonTop),
            RecordsButton.centerXAnchor.constraint(equalTo: SettingsButton.centerXAnchor),
        ])
    }
    
    @objc private func scrollBackground() {
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval.interval, repeats: true) { [weak self] _ in
            self?.scrollView.setContentOffset(CGPoint(x: CGFloat.x, y: (self?.scrollView.contentOffset.y ?? 0) - CGFloat.y), animated: true)
        }
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
    
    @objc private func stopTimer() {
        timer?.invalidate()
    }
}
