//
//  GalleryCollectionViewLayout.swift
//  Draw
//
//  Created by Марк Шнейдерман on 29.05.2021.
//

import UIKit

class GalleryCollectionViewLayout: UICollectionViewLayout {
    
      //MARK: - Create
    
    func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
    
              //MARK: - Items
            
            let smallItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                   heightDimension: .fractionalHeight(1.0)))
            
            smallItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)

            let bigItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.67),
                                               heightDimension: .fractionalHeight(1.0)))
            bigItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
            
            let middleItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(0.33)))
            middleItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)


        
              //MARK: - Group
            
            /// verticalGroup
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33),
                                                   heightDimension: .fractionalHeight(1.0)),
                subitem: middleItem, count: 2)

            /// FirstGroup
            let firstGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(0.3)),
                subitem: smallItem, count: 3)
            
            /// secondGroup
            let secondGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(0.7)),
                subitems: [bigItem, verticalGroup])
            
            /// thirdGroup
            let thirdGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(0.3)),
                subitem: smallItem, count: 3)

            /// fourGroup
            let fourGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(0.7)),
                subitems: [verticalGroup,bigItem])
            
              //MARK: - Halfs
            
            /// FirstHalf
            let firstHalfGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(0.5)),
                subitems: [firstGroup, secondGroup])
            
            /// SecondHalf
            let secondHalfGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.5)),
            subitems: [thirdGroup,fourGroup])
            
            /// general
            let generalGroup  = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)),
            subitems: [firstHalfGroup,secondHalfGroup])
            
              //MARK: - Section
            
            let section = NSCollectionLayoutSection(group: generalGroup)
            return section
            
        }
        return layout
    }
    
}
