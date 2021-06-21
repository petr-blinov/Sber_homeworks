//
//  FilterService.swift
//  Lesson19Homework_Filters
//
//  Created by Petr Blinov on 19.06.2021.
//

import UIKit

class FilterService: FilterServiceProtocol {
    
    // Создаем контекст вне скоупа функции фильтрации
    let context = CIContext()
    
    
    func doFilter(imageToFilter: UIImage, filterName: String, intensity: Int) -> UIImage {
        
        // Создаем фильтр (в качестве имени указываем строковую константу):
        if let filter = CIFilter(name: filterName) {
            
            // Конвертим нашу картинку в CIImage чтобы скормить ее фильтру (ему нужен CI):
            let ciImage = CIImage(image: imageToFilter)
            
            // Задаем значения фильтру: даем изображение и устаналиваем интенсивность, все задаем по ключам. Помним что у разных фильтров разные диапазоны интенсивности (0-1, 0-100)
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            filter.setValue(intensity, forKey: kCIInputIntensityKey)
            
            // Фильтруем и затем вытаскиваем CGImage из контекста:
            if let filteredImage = filter.outputImage {
                if let cgImage = context.createCGImage(filteredImage, from: filteredImage.extent) {
                    
                    // Конвертим CGImage в UIImage и возвращаем результат
                    let resultImage = UIImage(cgImage: cgImage)
                    return resultImage
                }
            }
        }
        // Возвращаем исходную картинку если фильтр не сработал
        return imageToFilter
    }
    
}
