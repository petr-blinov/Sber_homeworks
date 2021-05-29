//
//  FourthVC.swift
//  Lesson13Animation
//
//  Created by Петр Блинов on 28.05.2021.
//

import UIKit

class FourthVC: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CATransition"
        view.backgroundColor = .systemPink
        view.addSubview(buttonToNextVC)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        buttonToNextVC.frame = .init(x: view.bounds.width / 2 - 90, y: view.bounds.height * 0.85, width: 180, height: 44)
    }

    
    // Переход на следующий View Controller с анимацией CATransition
    
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
        let fourthVC = FifthVC()
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        transition.type = .fade
        navigationController?.view.layer.add(transition, forKey: "Переход_fade")
        
        // В пуше указываем FALSE для animated - чтобы он использовал нашу transition
        navigationController?.pushViewController(fourthVC, animated: false)
    }
}
