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
    
    private let leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        checkControl()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
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
                stopGame()
                showAlert()
            }
        }
    }
    
    private func stopGame() {
        timer?.invalidate()
        timer2?.invalidate()
        timer3?.invalidate()
    }
    
    @objc private func closeScreen() {
        stopGame()
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
    
    private func checkControl() {
        let control = settingsManager.getControl()
        switch control {
        case .tap:
            setUpTapControl()
        case .swipe:
            setUpSwipeControl()
        case .accelerometer:
            break
        }
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
    
    private func setUpSwipeControl() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(goLeft))
        swipeLeft.direction = .left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(goRight))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
    }
    
    private func setUpTapControl() {
    
        leftButton.addTarget(self, action: #selector(goLeft), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(goRight), for: .touchUpInside)
        
        view.addSubviews(views: leftButton, rightButton)
        
        NSLayoutConstraint.activate([
            leftButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            leftButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            
            rightButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            rightButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
    }
    
    @objc private func goLeft() {
        carObject.frame.origin = CGPoint(x: carObject.frame.origin.x - 60, y: carObject.frame.origin.y)
    }
    
    @objc private func goRight() {
        carObject.frame.origin = CGPoint(x: carObject.frame.origin.x + 60, y: carObject.frame.origin.y)
    }
    
    private func showAlert() {
        let back = UIAlertAction(title: "Назад", style: .default)
        let restart = UIAlertAction(title: "Повторить", style: .default)
        let save = UIAlertAction(title: "Сохранить результат", style: .default)
        let alertController = UIAlertController(title: "Ваш счет: 0", message: "", preferredStyle: .alert)
        alertController.addAction(restart)
        alertController.addAction(back)
        alertController.addAction(save)
        present(alertController, animated: true)
    }
}
