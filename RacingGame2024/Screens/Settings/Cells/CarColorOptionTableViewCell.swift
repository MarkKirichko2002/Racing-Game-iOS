//
//  CarColorOptionTableViewCell.swift
//  RacingGame
//
//  Created by Марк Киричко on 12.01.2024.
//

import UIKit

class CarColorOptionTableViewCell: UITableViewCell {

    static let identifier = "CarColorOptionTableViewCell"
    
    // MARK: - UI
    private let color: UIView = {
       let view = UIView()
       view.backgroundColor = .red
       view.layer.cornerRadius = 10
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
       label.text = "Цвет машины"
       label.textColor = .label
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(views: color, titleLabel)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Flow funcs
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            color.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            color.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            color.widthAnchor.constraint(equalToConstant: 80),
            color.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height),
            titleLabel.leftAnchor.constraint(equalTo: color.rightAnchor, constant: 20)
        ])
    }
}

