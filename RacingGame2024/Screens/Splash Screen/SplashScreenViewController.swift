//
//  SplashScreenViewController.swift
//  RacingGame
//
//  Created by Марк Киричко on 12.01.2024.
//

import UIKit

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
       label.font = .systemFont(ofSize: 22, weight: .black)
       label.text = "Гонки 2024"
       label.textColor = .white
       label.layer.opacity = 0
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
            icon.widthAnchor.constraint(equalToConstant: 150),
            icon.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 50)
        ])
    }
    
    private func showAnimation() {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let bottomCoordinate = CGPoint(x: screenWidth / 4, y: -screenHeight)
        
        UIView.animate(withDuration: 2.5) {
            self.titleLabel.layer.opacity = 1
        }
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            
            self.audioPlayerClass.playSound(sound: "car")
            
            UIView.animate(withDuration: 2, animations: {
                self.icon.frame.origin = bottomCoordinate
            })
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if self.icon.frame.origin.y < screenHeight {
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
