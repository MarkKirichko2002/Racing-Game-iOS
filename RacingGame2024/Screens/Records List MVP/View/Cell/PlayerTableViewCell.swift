//
//  PlayerTableViewCell.swift
//  RacingGame
//
//  Created by Марк Киричко on 12.01.2024.
//

import UIKit

private extension CGFloat {
    static let top: Self = 10
    static let left: Self = 20
    static let width: Self = 80
    static let height: Self = 80
}

private extension String {
    static let defaultImage = "racer"
}

private extension Int {
    static let numberOfLines = 0
}

class PlayerTableViewCell: UITableViewCell {

    static var identifier: String { "\(Self.self)" }
    
    // MARK: - UI
    private let playerImage: UIImageView = {
       let image = UIImageView()
       image.translatesAutoresizingMaskIntoConstraints = false
       return image
    }()
    
    private let playerName: UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.font = .systemFont(ofSize: Constants.fontSize, weight: Constants.fontWeight)
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: Constants.fontSize, weight: Constants.fontWeight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Int.numberOfLines
        label.textColor = .label
        label.font = .systemFont(ofSize: Constants.fontSize, weight: Constants.fontWeight)
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
            
            playerImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CGFloat.top),
            playerImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: CGFloat.left),
            playerImage.widthAnchor.constraint(equalToConstant: CGFloat.width),
            playerImage.heightAnchor.constraint(equalToConstant: CGFloat.height),
            
            playerName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CGFloat.top),
            playerName.leftAnchor.constraint(equalTo: playerImage.rightAnchor, constant: CGFloat.left),
            
            scoreLabel.topAnchor.constraint(equalTo: playerName.bottomAnchor, constant: CGFloat.top),
            scoreLabel.leftAnchor.constraint(equalTo: playerImage.rightAnchor, constant: CGFloat.left),
            
            dateLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: CGFloat.top),
            dateLabel.leftAnchor.constraint(equalTo: playerImage.rightAnchor, constant: CGFloat.left),
        ])
    }
    
    func configure(result: ResultModel) {
        if let image = result.image {
            playerImage.image = UIImage(data: image)
        } else {
            playerImage.image = UIImage(named: String.defaultImage)
        }
        playerName.text = result.playerName
        scoreLabel.text = "Счет: \(result.score)"
        dateLabel.text = "\(result.date) \(result.time)"
    }
}
