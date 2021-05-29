//
//  SecondVC.swift
//  Lesson13Animation
//
//  Created by Петр Блинов on 27.05.2021.
//

import UIKit

class SecondVC: UIViewController {
    
    lazy var buttonWithCABasicAnimation: UIButton = {
        let button = UIButton()
        button.setTitle("Via CABasic", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.sizeToFit()
        button.addTarget(self, action: #selector(animationStart), for: .touchUpInside)

        return button
    }()
    
    @objc func animationStart() {
        buttonWithCABasicAnimation.layer.removeAllAnimations()
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.3
        opacityAnimation.duration = 1
        opacityAnimation.repeatCount = 3
        buttonWithCABasicAnimation.layer.add(opacityAnimation, forKey: "Прозрачность")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CABasicAnimation"
        view.backgroundColor = .systemYellow
        view.addSubview(buttonWithCABasicAnimation)
        view.addSubview(buttonToNextVC)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        buttonWithCABasicAnimation.frame = .init(x: 30, y: view.bounds.height / 2, width: 135, height: 50)
        buttonToNextVC.frame = .init(x: view.bounds.width / 2 - 90, y: view.bounds.height * 0.85, width: 180, height: 44)
    }
 
    
    // Переход на следующий View Controller
    
    lazy var buttonToNextVC: UIButton = {
        let button = UIButton()
        button.setTitle("Next VC", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.sizeToFit()
        button.addTarget(self, action: #selector(goToNextVC), for: .touchUpInside)

        return button
    }()
    
    @objc func goToNextVC() {
        let thirdVC = ThirdVC()
        navigationController?.pushViewController(thirdVC, animated: true)
    }
    
}
