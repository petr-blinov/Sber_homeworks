//
//  FifthVC.swift
//  Lesson13Animation
//
//  Created by Петр Блинов on 28.05.2021.
//

import UIKit

class FifthVC: UIViewController {
        
    lazy var buttonWithCAAnimationGroup: UIButton = {
        let button = UIButton()
        button.setTitle("AnimationGroup", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.sizeToFit()
        button.addTarget(self, action: #selector(animationStart), for: .touchUpInside)

        return button
    }()
    
    @objc func animationStart() {
        
        buttonWithCAAnimationGroup.layer.removeAllAnimations()
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 9.5
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let currentX = buttonWithCAAnimationGroup.frame.midX
        let currentY = buttonWithCAAnimationGroup.frame.midY
        let pathArray = [[currentX, currentY],
                         [currentX, currentY - 100],
                         [currentX + 100, currentY - 100],
                         [currentX + 100, currentY],
                         [currentX, currentY]]
        positionAnimation.values = pathArray
        positionAnimation.duration = 3.5
        positionAnimation.repeatCount = 1
        positionAnimation.autoreverses = false

        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.systemBlue.cgColor
        colorAnimation.toValue = UIColor.systemPink.cgColor
        colorAnimation.autoreverses = true
        colorAnimation.duration = 1.5
        colorAnimation.repeatCount = 2
        colorAnimation.beginTime = positionAnimation.duration
        
        groupAnimation.animations = [positionAnimation, colorAnimation]
        buttonWithCAAnimationGroup.layer.add(groupAnimation, forKey: "Групповая анимация")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CAAnimationGroup"
        view.backgroundColor = .systemGreen
        view.addSubview(buttonWithCAAnimationGroup)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        buttonWithCAAnimationGroup.frame = .init(x: 30, y: view.bounds.height / 2, width: 135, height: 50)
    }
}
