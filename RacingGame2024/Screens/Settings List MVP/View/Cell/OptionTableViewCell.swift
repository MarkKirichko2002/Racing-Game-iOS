//
//  OptionTableViewCell.swift
//  RacingGame
//
//  Created by Марк Киричко on 12.01.2024.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

    static let identifier = "OptionTableViewCell"
    
    // MARK: - UI
    private let optionIcon: UIImageView = {
       let image = UIImageView()
       image.tintColor = .label
       image.translatesAutoresizingMaskIntoConstraints = false
       return image
    }()
    
    private let optionTitle: UILabel = {
       let label = UILabel()
       label.font = .systemFont(ofSize: 16, weight: .bold)
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
            
            optionIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            optionIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            optionIcon.widthAnchor.constraint(equalToConstant: 80),
            optionIcon.heightAnchor.constraint(equalToConstant: 80),
            
            optionTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height),
            optionTitle.leftAnchor.constraint(equalTo: optionIcon.rightAnchor, constant: 20)
        ])
    }
    
    func configure(option: Options, info: String) {
        optionIcon.image = UIImage(named: option.icon)
        optionTitle.text = info
    }
}
