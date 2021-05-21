//
//  GradientView.swift
//  UIKitLesson
//
//  Created by Петр Блинов on 20.05.2021.
//

import UIKit

final class GradientView: UIView {
    
    var colors = [UIColor]() {
        didSet {
            updateColors()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        gradientLayer.startPoint = .init(x: 0, y: 0)
        gradientLayer.endPoint = .init(x: 1, y: 1)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    private var gradientLayer: CAGradientLayer {
        layer as? CAGradientLayer ?? CAGradientLayer()
    }
    private func updateColors() {
        gradientLayer.colors = colors.map { $0.cgColor}
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        //point(inside: <#T##CGPoint#>, with: <#T##UIEvent?#>)
        return view
    }
}
