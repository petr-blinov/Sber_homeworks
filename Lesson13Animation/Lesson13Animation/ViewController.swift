//
//  ViewController.swift
//  Lesson13Animation
//
//  Created by Петр Блинов on 21.05.2021.
//

import UIKit

// Animation via Timer

class ViewController: UIViewController {
    
    lazy var homeworkButton: UIButton = {
        let homeworkButton = UIButton()
        homeworkButton.layer.cornerRadius = 70
        homeworkButton.backgroundColor = .systemRed
        homeworkButton.setTitle("Go to homework", for: .normal)
        homeworkButton.addTarget(self, action: #selector(presentHomework), for: .touchUpInside)
        return homeworkButton
    }()
    @objc func presentHomework() {
        let homeworkVC = HomeworkVC()
        present(homeworkVC, animated: true, completion: nil)
        
    }
    
    var timer: Timer?
    
    lazy var buttonWithAnimationViaTimer: UIButton = {
        let button = UIButton()
        button.setTitle("Via Timer", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.sizeToFit()
        button.addTarget(self, action: #selector(timerStart), for: .touchUpInside)
        return button
    }()
    @objc func timerStart() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(updateButton), userInfo: nil, repeats: true)
    }
    
    @objc func updateButton() {
        var exX: CGFloat
        var exY: CGFloat
        
        exX = buttonWithAnimationViaTimer.frame.minX
        exY = buttonWithAnimationViaTimer.frame.minY
       
        if (exX > (view.bounds.maxX - 135)) {
            timer?.invalidate()
            timer = nil
            return
        }
        buttonWithAnimationViaTimer.frame = .init(x: exX + 10, y: exY - 10, width: 135, height: 50)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation via Timer"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        view.addSubview(homeworkButton)
        view.addSubview(buttonWithAnimationViaTimer)
        view.addSubview(buttonToNextVC)

    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        homeworkButton.frame = .init(x: view.frame.width / 2 - 70, y: 170, width: 140, height: 140)
        buttonWithAnimationViaTimer.frame = .init(x: 30, y: view.bounds.height / 2, width: 135, height: 50)
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
        let secondVC = SecondVC()
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

