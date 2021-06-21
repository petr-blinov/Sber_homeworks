//
//  ToolProtocol.swift
//  Draw
//
//  Created by Марк Шнейдерман on 05.06.2021.
//

import UIKit

protocol ToolProtocol {
    var lineWidth: CGFloat  { get set }
    var lineColor: UIColor  { get set }
    var lineAlpha: CGFloat  { get set }
    var imageTool : UIImage? { get set }
    
    
    func setInitialPoint(_ firstPoint: CGPoint)
    func moveFromPoint(_ startPoint: CGPoint, toPoint endPoint: CGPoint)
    func draw()
}

