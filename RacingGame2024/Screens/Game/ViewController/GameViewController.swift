//
//  GameViewController.swift
//  RacingGame
//
//  Created by Марк Киричко on 11.01.2024.
//

import UIKit

private extension [String] {
    static var randomObjects = ["car red rotated", "car yellow rotated", "car orange rotated", "car blue rotated", "car green rotated"]
}

private extension CGFloat {
    static let fontSize: Self = 18
}

private extension TimeInterval {
    static let timeIntervalRunGame = 1.0
    static let timeIntervalBackground = 0.1
    static let timeIntervalTimer = 1.0
    static let timeIntervalCreateObject = 3.0
    static let timeIntervaUpdateObject = 0.016
}

private extension String {
    static let scoreLabelTitle = "Счет: 0"
    static let timeLabelTitle = "Время: 0 с"
    static let levelOfDifficultyLabelTitle = "Сложность: ..."
    static let backgroundMusic = "background music"
    static let explodeSound = "explode"
    static let restartTitle = "Повторить"
    static let leftIcon = "left"
    static let rightIcon = "right"
    static let saveTitle = "Сохранить результат"
    static let defaultString = "-"
    static let defaultPlayerName = "Игрок"
    static let gameOverTitle = "Игра окончена"
}

private extension CGFloat {
    static let defaultNumber = 0.0
    static let closeButtonTop = 50.0
    static let closeButtonRight = -20.0
    static let scoreLabelTop = 20.0
    static let scoreLabelRight = -20.0
    static let timeLabelTop = 45.0
    static let timeLabelRight = -20.0
    static let levelOfDifficultyLabelTop = 45.0
    static let levelOfDifficultyLabelRight = -20.0
    static let carObjectBottom = -30.0
    static let carObjectWidth = 70.0
    static let carObjectHeight = 70.0
    static let leftButtonBottom = -30.0
    static let leftButtonLeft = 30.0
    static let leftButtonWidth = 50.0
    static let leftButtonHeight = 50.0
    static let rightButtonBottom = -30.0
    static let rightButtonRight = -30.0
    static let rightButtonWidth = 50.0
    static let rightButtonHeight = 50.0
    static let backgroundOffSet = 100.0
    static let carObjectRightOffset = 60.0
    static let carObjectLeftOffset = 60.0
    
}

private extension Int {
    static let defaultNumber = 0
    static let increaseCount = 1
}

private extension Double {
    static let defaultNumber = 0.0
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
        label.text = String.scoreLabelTitle
        label.textColor = .white
        label.font = .systemFont(ofSize: CGFloat.fontSize, weight: Constants.fontWeight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = String.timeLabelTitle
        label.textColor = .white
        label.font = .systemFont(ofSize: CGFloat.fontSize, weight: Constants.fontWeight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let levelOfDifficultyLabel: UILabel = {
        let label = UILabel()
        label.text = String.levelOfDifficultyLabelTitle
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
    private var seconds = Int.defaultNumber
    private var score = Int.defaultNumber
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
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat.closeButtonTop),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: CGFloat.closeButtonRight),
            
            ScoreLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: CGFloat.scoreLabelTop),
            ScoreLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: CGFloat.scoreLabelRight),
            
            timeLabel.topAnchor.constraint(equalTo: ScoreLabel.topAnchor, constant: CGFloat.timeLabelTop),
            timeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: CGFloat.timeLabelRight),
            
            levelOfDifficultyLabel.topAnchor.constraint(equalTo: timeLabel.topAnchor, constant: CGFloat.levelOfDifficultyLabelTop),
            levelOfDifficultyLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: CGFloat.levelOfDifficultyLabelRight),
            
            carObject.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carObject.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat.carObjectBottom),
            carObject.widthAnchor.constraint(equalToConstant: CGFloat.carObjectWidth),
            carObject.heightAnchor.constraint(equalToConstant: CGFloat.carObjectHeight)
        ])
    }
    
    private func runGame() {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval.timeIntervalBackground, target: self, selector: #selector(scrollBackground), userInfo: nil, repeats: true)
        timer2 = Timer.scheduledTimer(timeInterval: TimeInterval.timeIntervalTimer, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
        // Запускаем бесконечный игровой цикл
        timer3 = Timer.scheduledTimer(timeInterval: TimeInterval.timeIntervalCreateObject, target: self, selector: #selector(createObject), userInfo: nil, repeats: true)
        // Запускаем бесконечный цикл для обновления движения квадратов
        timer4 = Timer.scheduledTimer(timeInterval: TimeInterval.timeIntervaUpdateObject, target: self, selector: #selector(updateObjects), userInfo: nil, repeats: true)
        audioPlayerClass.playSound(sound: String.backgroundMusic)
    }
    
    private func stopGame() {
        timer?.invalidate()
        timer2?.invalidate()
        timer3?.invalidate()
        timer4?.invalidate()
    }
    
    private func restartGame() {
        score = Int.defaultNumber
        seconds = Int.defaultNumber
        DispatchQueue.main.async { [weak self] in
            self?.scrollView.setContentOffset(CGPoint(x: Int.defaultNumber, y: Int.defaultNumber), animated: true)
            self?.ScoreLabel.text = "Счет: \(self?.score ?? Int.defaultNumber)"
            self?.timeLabel.text = "Время: \(self?.seconds ?? Int.defaultNumber) с"
        }
        Timer.scheduledTimer(withTimeInterval: TimeInterval.timeIntervalRunGame, repeats: false) { [weak self] _ in
            self?.runGame()
        }
    }
    
    @objc private func scrollBackground() {
        self.scrollView.setContentOffset(CGPoint(x: CGFloat.defaultNumber, y: self.scrollView.contentOffset.y - CGFloat.backgroundOffSet), animated: true)
    }
    
    @objc private func startTimer() {
        seconds += Int.increaseCount
        DispatchQueue.main.async { [weak self] in
            self?.timeLabel.text = "Время: \(self?.seconds ?? Int.defaultNumber) с"
        }
    }
    
    @objc private func createObject() {
        let obstacle = settingsManager.getObstacle()
        var randomObjects = Array.randomObjects
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
                audioPlayerClass.playSound(sound: String.explodeSound)
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
        leftButton.setImage(UIImage(named: String.leftIcon), for: .normal)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        let rightButton = UIButton()
        rightButton.setImage(UIImage(named: String.rightIcon), for: .normal)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        leftButton.addTarget(self, action: #selector(goLeft), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(goRight), for: .touchUpInside)
        
        view.addSubviews(views: leftButton, rightButton)
        
        NSLayoutConstraint.activate([
            leftButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat.leftButtonBottom),
            leftButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat.leftButtonLeft),
            leftButton.widthAnchor.constraint(equalToConstant: CGFloat.leftButtonWidth),
            leftButton.heightAnchor.constraint(equalToConstant: CGFloat.leftButtonHeight),
            
            rightButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat.rightButtonBottom),
            rightButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: CGFloat.rightButtonRight),
            rightButton.widthAnchor.constraint(equalToConstant: CGFloat.rightButtonWidth),
            rightButton.heightAnchor.constraint(equalToConstant: CGFloat.rightButtonHeight)
        ])
    }
    
    private func setUpAccelerometerControl() {
        accelerometerManager.checkAccelerometer()
        accelerometerManager.registerAccelerometerHandler { [weak self] xAcceleration in
            if xAcceleration > Double.defaultNumber {
                self?.goRight()
            } else {
                self?.goLeft()
            }
        }
    }
    
    @objc private func goLeft() {
        carObject.frame.origin = CGPoint(x: carObject.frame.origin.x - CGFloat.carObjectLeftOffset, y: carObject.frame.origin.y)
    }
    
    @objc private func goRight() {
        carObject.frame.origin = CGPoint(x: carObject.frame.origin.x + CGFloat.carObjectRightOffset, y: carObject.frame.origin.y)
    }
    
    private func increaseСounter() {
        score += Int.increaseCount
        DispatchQueue.main.async { [weak self] in
            self?.ScoreLabel.text = "Счет: \(self?.score ?? Int.defaultNumber)"
        }
    }
    
    private func showAlert() {
        let restart = UIAlertAction(title: String.restartTitle, style: .default) { [weak self] _ in
            self?.restartGame()
        }
        let save = UIAlertAction(title: String.saveTitle, style: .default) { [weak self] _ in
            let player = self?.settingsManager.getProfile()
            let currentDate = self?.dateManager.getCurrentDate() ?? String.defaultString
            let currentTime = self?.dateManager.getCurrentTime() ?? String.defaultString
            let result = ResultModel(playerName: player?.playerName ?? String.defaultPlayerName, image: player?.image, score: self?.score ?? Int.defaultNumber, date: currentDate, time: currentTime)
            self?.dataStorageManager.saveResult(result: result)
            self?.dismiss(animated: true)
        }
        let alertController = UIAlertController(title: String.gameOverTitle, message: "Ваш счет: \(score)", preferredStyle: .alert)
        alertController.addAction(restart)
        alertController.addAction(save)
        present(alertController, animated: true)
    }
}
