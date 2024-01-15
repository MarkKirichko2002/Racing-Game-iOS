//
//  GameViewController.swift
//  RacingGame
//
//  Created by Марк Киричко on 11.01.2024.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - UI
    private var closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let ScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Счет: 0"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время: 0 секунд"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let levelOfDifficultyLabel: UILabel = {
        let label = UILabel()
        label.text = "Сложность: ..."
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let carObject: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - vars/lets
    private let settingsManager = SettingsManager()
    private var timer: Timer?
    var seconds = 0
    var score = 0
    
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
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
        createCars()
    }
    
    // MARK: - Flow funcs
    private func setUpView() {
        view.backgroundColor = .systemBackground
        view.addSubviews(views: carObject, closeButton, ScoreLabel, timeLabel, levelOfDifficultyLabel)
        levelOfDifficultyLabel.text = "Уровень: \(settingsManager.getLevelOfDifficulty().title)"
        closeButton.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        setUpCar()
    }
        
    private func setUpCar() {
        carObject.backgroundColor = settingsManager.getCarColor().color
    }
    
    private func checkLevelOfDifficulty()-> Double {
        let level = settingsManager.getLevelOfDifficulty()
        switch level {
        case .easy:
            return 4.0
        case .normal:
            return 3.0
        case .hard:
            return 1.5
        }
    }
    
    @objc private func closeScreen() {
        stopTimer()
        dismiss(animated: true)
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            ScoreLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 20),
            ScoreLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            timeLabel.topAnchor.constraint(equalTo: ScoreLabel.topAnchor, constant: 45),
            timeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            levelOfDifficultyLabel.topAnchor.constraint(equalTo: timeLabel.topAnchor, constant: 45),
            levelOfDifficultyLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            carObject.widthAnchor.constraint(equalToConstant: 50),
            carObject.heightAnchor.constraint(equalToConstant: 50),
            
            carObject.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carObject.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func createCars() {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let bottomCoordinate = CGPoint(x: screenWidth / 4, y: screenHeight)
        
        let randomColors = [UIColor.systemRed, UIColor.systemYellow, UIColor.systemOrange, UIColor.systemBlue, UIColor.systemGreen]
        
        let level = self.checkLevelOfDifficulty()
        
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            let randomPosition = CGRect(x: screenWidth / 4, y: 100, width: 50, height: 50)
            let car = UIView(frame: randomPosition)
            car.backgroundColor = randomColors.randomElement()!
            self.view.addSubview(car)
            
            UIView.animate(withDuration: level, animations: {
                car.frame.origin = bottomCoordinate
            }) { _ in
                if car.frame.maxY >= screenHeight {
                    self.increaseСounter()
                }
            }
        }
    }
    
    private func increaseСounter() {
        score += 1
        DispatchQueue.main.async { [weak self] in
            self?.ScoreLabel.text = "Счет: \(self?.score ?? 0)"
        }
    }
    
    private func startTimer() {
        timer?.fire()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.seconds += 1
            DispatchQueue.main.async { [weak self] in
                self?.timeLabel.text = "Время: \(self?.seconds ?? 0) секунд"
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
        carObject.frame.origin = CGPoint(x: carObject.frame.origin.x - 60, y: carObject.frame.origin.y)
        print("left")
    }
    
    @objc private func swipeGestureRight() {
        carObject.frame.origin = CGPoint(x: carObject.frame.origin.x + 60, y: carObject.frame.origin.y)
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
