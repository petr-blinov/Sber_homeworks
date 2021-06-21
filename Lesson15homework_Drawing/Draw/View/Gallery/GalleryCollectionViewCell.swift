//
//  GalleryCollectionViewCell.swift
//  Draw
//
//  Created by Марк Шнейдерман on 29.05.2021.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
      //MARK: - Identifier
    
    static let identifier = "identifier1"
    
      //MARK: - UI
    lazy var imageView : UIImageView =  {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
      //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
      //MARK: - Layout
    func setLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
      //MARK: - Configure
    
    func configure(with image : UIImage?) {
        imageView.image = image
    }
    
}
