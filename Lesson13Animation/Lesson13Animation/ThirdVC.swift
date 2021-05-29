//
//  ThirdVC.swift
//  Lesson13Animation
//
//  Created by Петр Блинов on 27.05.2021.
//

import UIKit

class ThirdVC: UIViewController {
    
    lazy var buttonWithCAKeyframe: UIButton = {
        let button = UIButton()
        button.setTitle("Via CAKeyframe", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.brown, for: .normal)
        button.layer.cornerRadius = 10
        button.sizeToFit()
        button.addTarget(self, action: #selector(animationStart), for: .touchUpInside)

        return button
    }()
    
    @objc func animationStart() {
        
        buttonWithCAKeyframe.layer.removeAllAnimations()
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let currentX = buttonWithCAKeyframe.frame.midX
        let currentY = buttonWithCAKeyframe.frame.midY
        let pathArray = [[currentX, currentY],
                         [currentX + 50, currentY - 50],
                         [currentX + 100, currentY + 50],
                         [currentX + 150, currentY - 50],
                         [currentX + 200, currentY + 50],
                         [currentX + 250, currentY - 50]]
        positionAnimation.values = pathArray
        positionAnimation.duration = 3.5
        positionAnimation.repeatCount = 1
        positionAnimation.autoreverses = true
        buttonWithCAKeyframe.layer.add(positionAnimation, forKey: "Позиция")
        
        
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.systemYellow.cgColor
        colorAnimation.toValue = UIColor.systemOrange.cgColor
        colorAnimation.duration = 1
        colorAnimation.repeatCount = 7
        buttonWithCAKeyframe.layer.add(colorAnimation, forKey: "Цвет")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CAKeyframeAnimation"
        view.backgroundColor = .systemTeal
        view.addSubview(buttonWithCAKeyframe)
        view.addSubview(buttonToNextVC)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        buttonWithCAKeyframe.frame = .init(x: 30, y: view.bounds.height / 2, width: 135, height: 50)
        buttonToNextVC.frame = .init(x: view.bounds.width / 2 - 90, y: view.bounds.height * 0.85, width: 180, height: 44)
    }
    
    
    // Переход на следующий View Controller с анимацией CATransition
    
    lazy var buttonToNextVC: UIButton = {
        let button = UIButton()
        button.setTitle("CA Transition", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.sizeToFit()
        button.addTarget(self, action: #selector(goToNextVC), for: .touchUpInside)

        return button
    }()
    
    @objc func goToNextVC() {
        let fourthVC = FourthVC()
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = .moveIn
        transition.subtype = .fromTop
        navigationController?.view.layer.add(transition, forKey: "Переход_fade")
        
        // В пуше указываем FALSE для animated - чтобы он использовал нашу transition
        navigationController?.pushViewController(fourthVC, animated: false)
    }
    
}
