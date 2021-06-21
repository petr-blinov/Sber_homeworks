//
//  FilterServiceProtocol.swift
//  Lesson19Homework_Filters
//
//  Created by Petr Blinov on 20.06.2021.
//

import UIKit

protocol FilterServiceProtocol {
    func doFilter(imageToFilter: UIImage, filterName: String, intensity: Int) -> UIImage
}
