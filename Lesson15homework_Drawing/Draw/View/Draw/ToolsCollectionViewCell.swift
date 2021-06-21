//
//  DrawCollectionViewCell.swift
//  Draw
//
//  Created by Марк Шнейдерман on 29.05.2021.
//

import UIKit

class ToolsCollectionViewCell: UICollectionViewCell {
    
      //MARK: - Identifier
    
    static let  reuseIdentifier = "ToolsCellIdentifier"
    
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: .zero,
                                                  size: CGSize(width: self.bounds.width,
                                                               height: self.bounds.height)))
        return imageView
    }()
    
      //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
      //MARK: - Configure 
    
    func configure(with tool : ToolProtocol) {
        imageView.image = tool.imageTool
        imageView.tintColor = .black
    }
}
