//
//  ColorsTableView.swift
//  Draw
//
//  Created by Иван Казанцев on 07.06.2021.
//

import UIKit

class ColorsTableView : UITableView {
    
    var colors: [UIColor] = [.systemRed, .systemBlue, .systemPink, .systemTeal, .systemGray, .systemGreen, .systemOrange, .systemYellow, .systemPurple, .systemIndigo, .black]
    var currentColor: UIColor = .black
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: .zero, style: .plain)
        
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        isHidden = true
    }
    
    func pick(view: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.bottomAnchor, constant: 4),
            leftAnchor.constraint(equalTo: view.leftAnchor),
            heightAnchor.constraint(equalToConstant: 300),
            widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}

