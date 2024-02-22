//
//  GameViewController.swift
//  RacingGame
//
//  Created by Марк Киричко on 11.01.2024.
//

import UIKit

private extension CGFloat {
    static let fontSize: Self = 18
}

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
        button.setImage(UIImage(named: Constants.cross), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let ScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Счет: 0"
        label.textColor = .white
        label.font = .systemFont(ofSize: CGFloat.fontSize, weight: Constants.fontWeight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время: 0 с"
        label.textColor = .white
        label.font = .systemFont(ofSize: CGFloat.fontSize, weight: Constants.fontWeight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let levelOfDifficultyLabel: UILabel = {
        let label = UILabel()
        label.text = "Сложность: ..."
        label.textColor = .white
        label.font = .systemFont(ofSize: CGFloat.fontSize, weight: Constants.fontWeight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let carObject: UIImageView = {
        let car = UIImageView()
        car.translatesAutoresizingMaskIntoConstraints = false
        return car
    }()
    
    // MARK: - vars/lets
    private var seconds = 0
    private var score = 0
    private var objects: [GameObject] = []
    private var timer: Timer?
    private var timer2: Timer?
    private var timer3: Timer?
    private var timer4: Timer?
    private let accelerometerManager = AccelerometerManager()
    private let audioPlayerClass = AudioPlayerClass()
    private let dateManager = DateManager()
    private let dataStorageManager = DataStorageManager()
    private let settingsManager = SettingsManager()
    
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
        scrollView.backgroundColor = UIColor(patternImage: Constants.background)
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
            carObject.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
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
        audioPlayerClass.playSound(sound: "background music")
    }
    
    private func stopGame() {
        timer?.invalidate()
        timer2?.invalidate()
        timer3?.invalidate()
        timer4?.invalidate()
    }
    
    private func restartGame() {
        score = 0
        seconds = 0
        DispatchQueue.main.async { [weak self] in
            self?.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            self?.ScoreLabel.text = "Счет: \(self?.score ?? 0)"
            self?.timeLabel.text = "Время: \(self?.seconds ?? 0) с"
        }
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            self?.runGame()
        }
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
        }
        let object = GameObject()
        object.view.image = UIImage(named: randomObjects.randomElement()!)
        object.speed = settingsManager.checkLevelOfDifficulty()
        self.view.addSubview(object.view)
        objects.append(object)
    }
    
    @objc private func updateObjects() {
        
        for object in objects {
            
            object.view.frame.origin.y += object.speed
            
            if object.view.frame.origin.y > UIScreen.main.bounds.height {
                removeObject(object: object)
                increaseСounter()
            }
            
            if object.view.frame.intersects(carObject.frame) {
                audioPlayerClass.playSound(sound: "explode")
                stopGame()
                showAlert()
                removeObject(object: object)
            }
        }
    }
        
    private func removeObject(object: GameObject) {
        object.view.removeFromSuperview()
        if let index = objects.firstIndex(of: object) {
            objects.remove(at: index)
        }
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
        accelerometerManager.registerAccelerometerHandler { [weak self] xAcceleration in
            if xAcceleration > 0 {
                self?.goRight()
            } else {
                self?.goLeft()
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
        let restart = UIAlertAction(title: "Повторить", style: .default) { [weak self] _ in
            self?.restartGame()
        }
        let save = UIAlertAction(title: "Сохранить результат", style: .default) { [weak self] _ in
            let player = self?.settingsManager.getProfile()
            let currentDate = self?.dateManager.getCurrentDate() ?? "-"
            let currentTime = self?.dateManager.getCurrentTime() ?? "-"
            let result = ResultModel(playerName: player?.playerName ?? "Игрок", image: player?.image, score: self?.score ?? 0, date: currentDate, time: currentTime)
            self?.dataStorageManager.saveResult(result: result)
            self?.dismiss(animated: true)
        }
        let alertController = UIAlertController(title: "Игра окончена", message: "Ваш счет: \(score)", preferredStyle: .alert)
        alertController.addAction(restart)
        alertController.addAction(save)
        present(alertController, animated: true)
    }
}
