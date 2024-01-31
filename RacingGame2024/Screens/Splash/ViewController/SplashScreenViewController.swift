//
//  SplashScreenViewController.swift
//  RacingGame
//
//  Created by Марк Киричко on 12.01.2024.
//

import UIKit

private extension Float {
    static let opacity: Self = 0
    static let opacity2: Self = 1
}

private extension CGFloat {
    static let x: Self = UIScreen.main.bounds.width / 4
    static let y: Self = UIScreen.main.bounds.height
    static let fontSize: Self = 22
    static let width: Self = 150
    static let height: Self = 150
    static let height2: Self = 30
    static let top: Self = 50
}

private extension TimeInterval {
    static let duration: Self = 2
    static let duration2: Self = 3
    static let duration3: Self = 1
}

class SplashScreenViewController: UIViewController {

    private let animation = AnimationManager()
    private let audioPlayerClass = AudioPlayerClass()
    private let settingsManager = SettingsManager()
    
    // MARK: - UI
    private let icon: UIImageView = {
       let image = UIImageView()
       image.translatesAutoresizingMaskIntoConstraints = false
       return image
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
       label.font = .systemFont(ofSize: CGFloat.fontSize, weight: .black)
       label.text = Constants.title
       label.textColor = .white
       label.layer.opacity = Float.opacity
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        makeConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        icon.image = UIImage(named: settingsManager.getCarColor().image)
        showAnimation()
    }
    
    private func setUpView() {
        view.addSubviews(views: icon, titleLabel)
    }
    
    private func makeConstraints() {
        
        NSLayoutConstraint.activate([
            
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            icon.widthAnchor.constraint(equalToConstant: CGFloat.width),
            icon.heightAnchor.constraint(equalToConstant: CGFloat.height),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: CGFloat.height2),
            titleLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: CGFloat.top)
        ])
    }
    
    private func showAnimation() {
        
        let bottomCoordinate = CGPoint(x: CGFloat.x, y: -CGFloat.y)
        
        UIView.animate(withDuration: TimeInterval.duration) {
            self.titleLabel.layer.opacity = Float.opacity2
        }
        
        Timer.scheduledTimer(withTimeInterval: TimeInterval.duration2, repeats: false) { _ in
            
            self.audioPlayerClass.playSound(sound: "car")
            
            UIView.animate(withDuration: TimeInterval.duration, animations: {
                self.icon.frame.origin = bottomCoordinate
            })
            
            Timer.scheduledTimer(withTimeInterval: TimeInterval.duration3, repeats: true) { timer in
                if self.icon.frame.origin.y < CGFloat.y {
                    self.audioPlayerClass.playSound(sound: "explode")
                    self.showStartScreen()
                    timer.invalidate()
                }
            }
        }
    }
    
    private func showStartScreen() {
        let controller = StartViewController()
        controller.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async { [weak self] in
            self?.present(controller, animated: false, completion: nil)
        }
    }
}
