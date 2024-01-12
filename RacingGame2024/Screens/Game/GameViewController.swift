//
//  GameViewController.swift
//  RacingGame
//
//  Created by Марк Киричко on 11.01.2024.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - UI
    private let ScoreLabel: UILabel = {
       let label = UILabel()
       label.text = "Счет: 0"
       label.textColor = .white
       label.font = .systemFont(ofSize: 18, weight: .bold)
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время: 0 секунд"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let carObject: UIImageView = {
       let car = UIImageView()
       car.image = UIImage(named: "car")
       car.translatesAutoresizingMaskIntoConstraints = false
       return car
    }()
    
    // MARK: - vars
    private var timer: Timer?
    var seconds = 0
    
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpNavigation()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpGestures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }
    
    // MARK: - Flow funcs
    private func setUpView() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        view.addSubviews(views: carObject, ScoreLabel, timeLabel)
    }
    
    private func setUpNavigation() {
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeScreen))
        closeButton.tintColor = .white
        navigationItem.rightBarButtonItem = closeButton
    }
    
    @objc private func closeScreen() {
        stopTimer()
        dismiss(animated: true)
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            ScoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            ScoreLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            timeLabel.topAnchor.constraint(equalTo: ScoreLabel.topAnchor, constant: 45),
            timeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            carObject.widthAnchor.constraint(equalToConstant: 70),
            carObject.heightAnchor.constraint(equalToConstant: 70),
            
            carObject.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carObject.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func startTimer() {
        timer?.fire()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.seconds += 1
            DispatchQueue.main.async {
                self.timeLabel.text = "Время: \(self.seconds) секунд"
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
    }
    
    private func setUpGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureLeft))
        swipeLeft.direction = .left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureRight))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
    }
    
    @objc private func swipeGestureLeft() {
        print("left")
        showAlert()
    }
    
    @objc private func swipeGestureRight() {
        print("right")
    }
    
    private func showAlert() {
        let back = UIAlertAction(title: "Назад", style: .default)
        let restart = UIAlertAction(title: "Повторить", style: .default)
        let save = UIAlertAction(title: "Сохранить результат", style: .default)
        let alertController = UIAlertController(title: "Ваш счет: 10", message: "", preferredStyle: .alert)
        alertController.addAction(restart)
        alertController.addAction(back)
        alertController.addAction(save)
        present(alertController, animated: true)
    }
}

