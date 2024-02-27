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
    static let iconWidth: Self = 150
    static let iconHeight: Self = 150
    static let titleLabelHeight: Self = 30
    static let titleLabelTop: Self = 50
}

private extension TimeInterval {
    static let duration: Self = 2
    static let duration2: Self = 3
    static let duration3: Self = 1
}

private extension String {
    static let carSound = "car"
    static let explodeSound = "explode"
}

final class SplashScreenViewController: UIViewController {

    private let animationManager: IAnimationManager
    private let audioPlayerClass: IAudioPlayerClass
    private let settingsManager: ISettingsManager
    
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
    
    init(animationManager: IAnimationManager, audioPlayerClass: IAudioPlayerClass, settingsManager: ISettingsManager) {
        self.animationManager = animationManager
        self.audioPlayerClass = audioPlayerClass
        self.settingsManager = settingsManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            icon.widthAnchor.constraint(equalToConstant: CGFloat.iconWidth),
            icon.heightAnchor.constraint(equalToConstant: CGFloat.iconHeight),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: CGFloat.titleLabelHeight),
            titleLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: CGFloat.titleLabelTop)
        ])
    }
    
    private func showAnimation() {
        
        let bottomCoordinate = CGPoint(x: CGFloat.x, y: -CGFloat.y)
        
        UIView.animate(withDuration: TimeInterval.duration) {
            self.titleLabel.layer.opacity = Float.opacity2
        }
        
        Timer.scheduledTimer(withTimeInterval: TimeInterval.duration2, repeats: false) { [weak self] _ in
            
            self?.audioPlayerClass.playSound(sound: String.carSound)
            
            UIView.animate(withDuration: TimeInterval.duration, animations: {
                self?.icon.frame.origin = bottomCoordinate
            })
            
            Timer.scheduledTimer(withTimeInterval: TimeInterval.duration3, repeats: true) { [weak self] timer in
                if (self?.icon.frame.origin.y ?? 0) < CGFloat.y {
                    self?.audioPlayerClass.playSound(sound: String.explodeSound)
                    self?.showStartScreen()
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
