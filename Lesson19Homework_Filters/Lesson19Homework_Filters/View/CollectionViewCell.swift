//
//  CollectionViewCell.swift
//  Lesson19Homework_Filters
//
//  Created by Petr Blinov on 20.06.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FilterCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let filterNameLabel: UILabel = {
        let filterNameLabel = UILabel()
        filterNameLabel.textColor = .systemBlue
        filterNameLabel.backgroundColor = .white
        filterNameLabel.textAlignment = .center
        filterNameLabel.adjustsFontSizeToFitWidth = true
        filterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return filterNameLabel
    }()
    
    func configure(with filterNamesModel: FilterNamesModel, filterPreviewModel: FilterPreviewModel, index: Int) {
        imageView.image = filterPreviewModel.imagesForPreview[index]
        filterNameLabel.text = "\(filterNamesModel.filters[index])"
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func updateConstraints() {
        
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: filterNameLabel.topAnchor),

            filterNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filterNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            filterNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        super.updateConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(imageView)
        addSubview(filterNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
