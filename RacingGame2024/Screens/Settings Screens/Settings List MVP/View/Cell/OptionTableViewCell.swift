//
//  OptionTableViewCell.swift
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

class OptionTableViewCell: UITableViewCell {

    static var identifier: String { "\(Self.self)" }
    
    // MARK: - UI
    private let optionIcon: UIImageView = {
       let image = UIImageView()
       image.translatesAutoresizingMaskIntoConstraints = false
       return image
    }()
    
    private let optionTitle: UILabel = {
       let label = UILabel()
       label.font = .systemFont(ofSize: Constants.fontSize, weight: Constants.fontWeight)
       label.textColor = .label
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(views: optionIcon, optionTitle)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Flow funcs
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            optionIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CGFloat.top),
            optionIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: CGFloat.left),
            optionIcon.widthAnchor.constraint(equalToConstant: CGFloat.width),
            optionIcon.heightAnchor.constraint(equalToConstant: CGFloat.height),
            
            optionTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height),
            optionTitle.leftAnchor.constraint(equalTo: optionIcon.rightAnchor, constant: CGFloat.left)
        ])
    }
    
    func configure(option: Options, info: String) {
        optionIcon.image = UIImage(named: option.icon)
        optionTitle.text = info
    }
    
    func configureProfileCell(profile: ProfileModel) {
        if let image = profile.image {
            optionIcon.image = UIImage(data: image)
        } else {
            optionIcon.image = UIImage(named: "racer")
        }
        optionTitle.text = profile.playerName
    }
}
