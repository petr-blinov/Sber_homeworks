//
//  DataManager.swift
//  Draw
//
//  Created by Марк Шнейдерман on 05.06.2021.
//

import UIKit


class DataManager {
    
      //MARK: - Singelton
    
    static let shared = DataManager()
    
      //MARK: - Properties
    
    var images = [UIImage]()
    
      //MARK: - Init
    
    /// Сделали фотки чтобы показать какой у нас красивый collectionView вначале
    init() {
        images.append(UIImage(named: "plus")!)
        images.append(UIImage(named: "фото_1")!)
        images.append(UIImage(named: "фото_2")!)
        images.append(UIImage(named: "фото_3")!)
        images.append(UIImage(named: "фото_4")!)
        images.append(UIImage(named: "фото_5")!)
        images.append(UIImage(named: "фото_6")!)
        images.append(UIImage(named: "фото_7")!)
        images.append(UIImage(named: "фото_8")!)
        images.append(UIImage(named: "фото_9")!)
        images.append(UIImage(named: "фото_10")!)
        images.append(UIImage(named: "фото_11")!)
        images.append(UIImage(named: "фото_12")!)
    }
    
      //MARK: - Add
    
    func add(with image : UIImage) {
        images.insert(image, at: 1)
    }
    
}
