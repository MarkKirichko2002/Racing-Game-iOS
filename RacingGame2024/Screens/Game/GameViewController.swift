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
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время: 0 с"
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let levelOfDifficultyLabel: UILabel = {
        let label = UILabel()
        label.text = "Сложность: ..."
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let carObject: UIImageView = {
        let car = UIImageView()
        car.image = UIImage(named: "car icon")
        car.translatesAutoresizingMaskIntoConstraints = false
        return car
    }()
    
    // MARK: - vars/lets
    private let settingsManager = SettingsManager()
    private var timer: Timer?
    private var timer2: Timer?
    private var timer3: Timer?
    private var objects: [GameObject] = []
    
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
        runGame()
        startTimer()
    }
    
    // MARK: - Flow funcs
    private func setUpView() {
        view.backgroundColor = .systemBackground
        view.addSubviews(views: carObject, closeButton, ScoreLabel, timeLabel, levelOfDifficultyLabel)
        levelOfDifficultyLabel.text = "Уровень: \(settingsManager.getLevelOfDifficulty().title)"
        closeButton.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        carObject.image = UIImage(named: settingsManager.getCarColor().image)
    }
    
    private func runGame() {
        // Запускаем бесконечный игровой цикл
        timer2 = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(createObject), userInfo: nil, repeats: true)
        
        // Запускаем бесконечный цикл для обновления движения квадратов
        timer3 = Timer.scheduledTimer(timeInterval: 1 / 60, target: self, selector: #selector(updateObjects), userInfo: nil, repeats: true)
    }
    
    @objc func createObject() {
        let randomCars = ["car red rotated", "car yellow rotated", "car orange rotated", "car blue rotated", "car green rotated"]
        let car = GameObject()
        car.view.image = UIImage(named: randomCars.randomElement()!)
        self.view.addSubview(car.view)
        objects.append(car)
    }
    
    @objc func updateObjects() {
        
        // Обновляем положение каждого обьекта
        for object in objects {
            
            object.view.frame.origin.y += object.speed
            
            // Проверяем, вышел ли квадрат за границы экрана
            if object.view.frame.origin.y > UIScreen.main.bounds.height {
                // Уничтожаем квадрат
                object.view.removeFromSuperview()
                if let index = objects.firstIndex(of: object) {
                    objects.remove(at: index)
                }
            }
            
            if object.view.frame.intersects(carObject.frame) {
                print("Столкновение")
                timer?.invalidate()
                timer2?.invalidate()
                timer3?.invalidate()
                showAlert()
            }
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
            
            carObject.widthAnchor.constraint(equalToConstant: 70),
            carObject.heightAnchor.constraint(equalToConstant: 70),
            
            carObject.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carObject.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func increaseСounter() {
        var score = 0
        score += 1
        DispatchQueue.main.async { [weak self] in
            self?.ScoreLabel.text = "Счет: \(score)"
        }
    }
    
    private func startTimer() {
        var seconds = 0
        timer?.fire()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            seconds += 1
            DispatchQueue.main.async { [weak self] in
                self?.timeLabel.text = "Время: \(seconds) с"
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
    }
    
    @objc private func swipeGestureRight() {
        carObject.frame.origin = CGPoint(x: carObject.frame.origin.x + 60, y: carObject.frame.origin.y)
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
