//
//  FilterModel.swift
//  Lesson19Homework_Filters
//
//  Created by Petr Blinov on 20.06.2021.
//

import Foundation

// Получаем список фильтров у которых есть параметр интенсивности:
//let filters = CIFilter.filterNames(inCategory: kCICategoryBuiltIn).filter { filterName in
//    CIFilter(name: filterName)?.inputKeys.contains(kCIInputIntensityKey) ?? false
//}


// Берем для использования только те, которые нам нравятся

struct FilterNamesModel {
    let filters = ["CISepiaTone", "CIUnsharpMask", "CIEdges", "CIBloom", "CIColorMonochrome", "CIGloom", "CIVignette"]
}

