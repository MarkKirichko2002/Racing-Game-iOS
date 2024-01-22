//
//  PlayerTableViewCell.swift
//  RacingGame
//
//  Created by Марк Киричко on 12.01.2024.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    static let identifier = "PlayerTableViewCell"
    
    // MARK: - UI
    private let playerImage: UIImageView = {
       let image = UIImageView()
       image.image = UIImage(named: "racer")
       image.tintColor = .label
       image.translatesAutoresizingMaskIntoConstraints = false
       return image
    }()
    
    private let playerName: UILabel = {
       let label = UILabel()
       label.text = "Игрок"
       label.textColor = .label
       label.font = .systemFont(ofSize: 16, weight: .bold)
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "счет: 10"
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "12.01.2024 12:30"
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(views: playerImage, playerName, scoreLabel, dateLabel)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Flow funcs
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            
            playerImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            playerImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            playerImage.widthAnchor.constraint(equalToConstant: 80),
            playerImage.heightAnchor.constraint(equalToConstant: 80),
            
            playerName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            playerName.leftAnchor.constraint(equalTo: playerImage.rightAnchor, constant: 20),
            
            scoreLabel.topAnchor.constraint(equalTo: playerName.bottomAnchor, constant: 10),
            scoreLabel.leftAnchor.constraint(equalTo: playerImage.rightAnchor, constant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 10),
            dateLabel.leftAnchor.constraint(equalTo: playerImage.rightAnchor, constant: 20),
        ])
    }
    
    func configure(result: ResultModel) {
        playerName.text = result.playerName
        scoreLabel.text = "Счет: \(result.score)"
        dateLabel.text = "\(result.date) \(result.time)"
    }
}
