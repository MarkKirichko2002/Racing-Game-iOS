//
//  SplashScreenViewController.swift
//  RacingGame
//
//  Created by Марк Киричко on 12.01.2024.
//

import UIKit

class SplashScreenViewController: UIViewController {

    let animation = AnimationManager()
    
    // MARK: - UI
    private let icon: UIImageView = {
       let image = UIImageView()
       image.image = UIImage(named: "racer")
       image.tintColor = .label
       image.translatesAutoresizingMaskIntoConstraints = false
       return image
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
       label.font = .systemFont(ofSize: 22, weight: .black)
       label.text = "Гонки 2024"
       label.textColor = .label
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
        showAnimation()
    }
    
    private func setUpView() {
        view.backgroundColor = .systemBackground
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
        
        UIView.animate(withDuration: 2.5) {
            self.titleLabel.layer.opacity = 1
        }
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.animation.springView(view: self.icon)
        }
    
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            self.showStartScreen()
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
