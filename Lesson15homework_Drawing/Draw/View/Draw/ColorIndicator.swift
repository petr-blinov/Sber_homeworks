//
//  ColorIndicator.swift
//  Draw
//
//  Created by Иван Казанцев on 07.06.2021.
//

import UIKit

class ColorIndicator: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: .zero)
        backgroundColor = .black
        layer.cornerRadius = 5
        layer.borderColor = UIColor.black.cgColor
    }

}
