//
//  GameViewController.swift
//  RacingGame
//
//  Created by Марк Киричко on 11.01.2024.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - UI
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = false
        return scrollView
    }()
    
    private var closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(named: "cross"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
        label.text = "Время: 0 с"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let levelOfDifficultyLabel: UILabel = {
        let label = UILabel()
        label.text = "Сложность: ..."
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let carObject: UIImageView = {
        let car = UIImageView()
        car.translatesAutoresizingMaskIntoConstraints = false
        return car
    }()
    
    // MARK: - vars/lets
    private let settingsManager = SettingsManager()
    private var seconds = 0
    private var timer: Timer?
    private var timer2: Timer?
    private var timer3: Timer?
    private var timer4: Timer?
    private var objects: [GameObject] = []
    private let accelerometerManager = AccelerometerManager()
    private let audioPlayerClass = AudioPlayerClass()
    private var score = 0
    
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
    }
    
    // MARK: - Flow funcs
    private func setUpView() {
        view.addSubview(scrollView)
        scrollView.frame = view.bounds
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        view.addSubviews(views: carObject, closeButton, ScoreLabel, timeLabel, levelOfDifficultyLabel)
        carObject.image = UIImage(named: settingsManager.getCarColor().image)
        levelOfDifficultyLabel.text = "Уровень: \(settingsManager.getLevelOfDifficulty().title)"
        closeButton.addTarget(self, action: #selector(closeGameScreen), for: .touchUpInside)
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
            
            carObject.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carObject.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            carObject.widthAnchor.constraint(equalToConstant: 70),
            carObject.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func runGame() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(scrollBackground), userInfo: nil, repeats: true)
        timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
        // Запускаем бесконечный игровой цикл
        timer3 = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(createObject), userInfo: nil, repeats: true)
        // Запускаем бесконечный цикл для обновления движения квадратов
        timer4 = Timer.scheduledTimer(timeInterval: 1 / 60, target: self, selector: #selector(updateObjects), userInfo: nil, repeats: true)
    }
    
    @objc private func scrollBackground() {
        self.scrollView.setContentOffset(CGPoint(x: 0, y: self.scrollView.contentOffset.y - 100), animated: true)
    }
    
    @objc private func startTimer() {
        seconds += 1
        DispatchQueue.main.async { [weak self] in
            self?.timeLabel.text = "Время: \(self?.seconds ?? 0) с"
        }
    }
    
    @objc private func createObject() {
        let obstacle = settingsManager.getObstacle()
        var randomObjects = ["car red rotated", "car yellow rotated", "car orange rotated", "car blue rotated", "car green rotated"]
        if obstacle != .none {
            randomObjects.append(obstacle.image)
        } else {}
        let object = GameObject()
        object.view.image = UIImage(named: randomObjects.randomElement()!)
        self.view.addSubview(object.view)
        objects.append(object)
    }
    
    @objc private func updateObjects() {
        
        // Обновляем положение каждого обьекта
        for object in objects {
            
            object.view.frame.origin.y += object.speed
            
            // Проверяем, вышел ли квадрат за границы экрана
            if object.view.frame.origin.y > UIScreen.main.bounds.height {
                // Уничтожаем квадрат
                object.view.removeFromSuperview()
                if let index = objects.firstIndex(of: object) {
                    objects.remove(at: index)
                    increaseСounter()
                }
            }
            
            if object.view.frame.intersects(carObject.frame) {
                audioPlayerClass.playSound(sound: "explode")
                stopGame()
                showAlert()
            }
        }
    }
    
    private func stopGame() {
        timer?.invalidate()
        timer2?.invalidate()
        timer3?.invalidate()
        timer4?.invalidate()
    }
    
    @objc private func closeGameScreen() {
        stopGame()
        accelerometerManager.stopAccelerometerUpdates()
        dismiss(animated: true)
    }
    
    private func checkControl() {
        let control = settingsManager.getControl()
        switch control {
        case .tap:
            setUpTapControl()
        case .swipe:
            setUpSwipeControl()
        case .accelerometer:
            setUpAccelerometerControl()
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
        
        let leftButton = UIButton()
        leftButton.setImage(UIImage(named: "left"), for: .normal)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        let rightButton = UIButton()
        rightButton.setImage(UIImage(named: "right"), for: .normal)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        leftButton.addTarget(self, action: #selector(goLeft), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(goRight), for: .touchUpInside)
        
        view.addSubviews(views: leftButton, rightButton)
        
        NSLayoutConstraint.activate([
            leftButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            leftButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            leftButton.heightAnchor.constraint(equalToConstant: 50),
            leftButton.widthAnchor.constraint(equalToConstant: 50),
            
            rightButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            rightButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            rightButton.heightAnchor.constraint(equalToConstant: 50),
            rightButton.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setUpAccelerometerControl() {
        accelerometerManager.checkAccelerometer()
        accelerometerManager.registerAccelerometerHandler { xAcceleration in
            if xAcceleration > 0 {
                self.goRight()
            } else {
                self.goLeft()
            }
        }
    }
    
    @objc private func goLeft() {
        carObject.frame.origin = CGPoint(x: carObject.frame.origin.x - 60, y: carObject.frame.origin.y)
    }
    
    @objc private func goRight() {
        carObject.frame.origin = CGPoint(x: carObject.frame.origin.x + 60, y: carObject.frame.origin.y)
    }
    
    private func increaseСounter() {
        score += 1
        DispatchQueue.main.async { [weak self] in
            self?.ScoreLabel.text = "Счет: \(self?.score ?? 0)"
        }
    }
    
    private func showAlert() {
        let back = UIAlertAction(title: "Назад", style: .default)
        let restart = UIAlertAction(title: "Повторить", style: .default)
        let save = UIAlertAction(title: "Сохранить результат", style: .default)
        let alertController = UIAlertController(title: "Ваш счет: \(score)", message: "", preferredStyle: .alert)
        alertController.addAction(restart)
        alertController.addAction(back)
        alertController.addAction(save)
        present(alertController, animated: true)
    }
}
