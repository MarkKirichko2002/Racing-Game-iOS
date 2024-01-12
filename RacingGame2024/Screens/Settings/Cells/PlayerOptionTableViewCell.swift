//
//  PlayerOptionTableViewCell.swift
//  RacingGame
//
//  Created by Марк Киричко on 12.01.2024.
//

import UIKit

class PlayerOptionTableViewCell: UITableViewCell {

    static let identifier = "PlayerOptionTableViewCell"
    
    // MARK: - UI
    private let playerImage: UIImageView = {
       let image = UIImageView()
       image.image = UIImage(named: "finish")
       image.translatesAutoresizingMaskIntoConstraints = false
       return image
    }()
    
    private let playerName: UILabel = {
       let label = UILabel()
       label.text = "Игрок"
       label.textColor = .label
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(views: playerImage, playerName)
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
            
            playerName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height),
            playerName.leftAnchor.constraint(equalTo: playerImage.rightAnchor, constant: 20)
        ])
    }
}

