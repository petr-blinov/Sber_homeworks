//
//  ColorsTableViewCell.swift
//  Draw
//
//  Created by Иван Казанцев on 07.06.2021.
//

import UIKit

class ColorsTableViewCell: UITableViewCell {

    lazy var colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.black.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(colorView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            colorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            colorView.leftAnchor.constraint(equalTo: self.leftAnchor),
            colorView.topAnchor.constraint(equalTo: self.topAnchor),
            colorView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    func configure(with color: UIColor) {
        colorView.backgroundColor = color
    }

}
