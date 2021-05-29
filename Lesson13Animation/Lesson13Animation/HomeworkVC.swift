//
//  HomeworkVC.swift
//  Lesson13Animation
//
//  Created by Петр Блинов on 29.05.2021.
//

import UIKit

class HomeworkVC: UIViewController {

    var timer: Timer?

    var actionView = UIView()
    
    var image00 = UIImageView(image: UIImage(named: "00"))
    var image01 = UIImageView(image: UIImage(named: "01"))
    var image02 = UIImageView(image: UIImage(named: "02"))
    var image03 = UIImageView(image: UIImage(named: "03"))
    var image04 = UIImageView(image: UIImage(named: "04"))
    var image05 = UIImageView(image: UIImage(named: "05"))
    var image06 = UIImageView(image: UIImage(named: "06"))
    var image07 = UIImageView(image: UIImage(named: "07"))
    var image08 = UIImageView(image: UIImage(named: "08"))
    var image09 = UIImageView(image: UIImage(named: "09"))

    
    lazy var buttonStart: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.sizeToFit()
        button.addTarget(self, action: #selector(startAnimation00), for: .touchUpInside)
        return button
    }()
    
    @objc func startAnimation00() {
        
        setAllImagesAlphaToZero()
        
        image00.layer.removeAllAnimations()
        let animation00 = CABasicAnimation(keyPath: "opacity")
        animation00.fromValue = 0
        animation00.toValue = 1
        animation00.duration = 3
        animation00.repeatCount = 1
        animation00.autoreverses = false
        image00.layer.add(animation00, forKey: "00")
        image00.alpha = 1
        
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(startAnimation01), userInfo: nil, repeats: true)
    }
    
    @objc func startAnimation01() {
        
        image01.layer.removeAllAnimations()
        let animation01 = CABasicAnimation(keyPath: "opacity")
        animation01.fromValue = 0
        animation01.toValue = 1
        animation01.duration = 4
        animation01.repeatCount = 1
        animation01.autoreverses = false
        image01.layer.add(animation01, forKey: "01")
        image01.alpha = 1
        
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(startAnimation02), userInfo: nil, repeats: true)
    }
    
    @objc func startAnimation02() {
        
        image02.layer.removeAllAnimations()
        let animation02 = CABasicAnimation(keyPath: "opacity")
        animation02.fromValue = 0
        animation02.toValue = 1
        animation02.duration = 2
        animation02.repeatCount = 1
        animation02.autoreverses = true
        image02.layer.add(animation02, forKey: "02")
        
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(startAnimation03), userInfo: nil, repeats: true)
    }
    
    @objc func startAnimation03() {
        
        image03.layer.removeAllAnimations()
        let animation03 = CABasicAnimation(keyPath: "opacity")
        animation03.fromValue = 0
        animation03.toValue = 1
        animation03.duration = 2
        animation03.repeatCount = 1
        animation03.autoreverses = true
        image03.layer.add(animation03, forKey: "03")
        
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(startAnimation04), userInfo: nil, repeats: true)
    }
    
    @objc func startAnimation04() {
        
        image04.layer.removeAllAnimations()
        let animation04 = CABasicAnimation(keyPath: "opacity")
        animation04.fromValue = 0
        animation04.toValue = 1
        animation04.duration = 2
        animation04.repeatCount = 1
        animation04.autoreverses = true
        image04.layer.add(animation04, forKey: "04")
        
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(startAnimation05), userInfo: nil, repeats: true)
    }
    
    @objc func startAnimation05() {
        
        image05.layer.removeAllAnimations()
        let animation05 = CABasicAnimation(keyPath: "opacity")
        animation05.fromValue = 0
        animation05.toValue = 1
        animation05.duration = 2
        animation05.repeatCount = 1
        animation05.autoreverses = true
        image05.layer.add(animation05, forKey: "05")
        
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(startAnimation06), userInfo: nil, repeats: true)
    }
    
    @objc func startAnimation06() {

        image06.layer.removeAllAnimations()
        let animation06 = CABasicAnimation(keyPath: "opacity")
        animation06.fromValue = 0
        animation06.toValue = 1
        animation06.duration = 2
        animation06.repeatCount = 1
        animation06.autoreverses = true
        image06.layer.add(animation06, forKey: "06")
        
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(startAnimation07), userInfo: nil, repeats: true)
    }
    
    @objc func startAnimation07() {

        image07.layer.removeAllAnimations()
        let animation07 = CABasicAnimation(keyPath: "opacity")
        animation07.fromValue = 0
        animation07.toValue = 1
        animation07.duration = 2
        animation07.repeatCount = 1
        animation07.autoreverses = true
        image07.layer.add(animation07, forKey: "07")
        
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(startAnimation08), userInfo: nil, repeats: true)
    }
    
    @objc func startAnimation08() {

        image08.layer.removeAllAnimations()
        let animation08 = CABasicAnimation(keyPath: "opacity")
        animation08.fromValue = 0
        animation08.toValue = 1
        animation08.duration = 2
        animation08.repeatCount = 1
        animation08.autoreverses = true
        image08.layer.add(animation08, forKey: "08")
        
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(startAnimation09), userInfo: nil, repeats: true)
    }
    
    @objc func startAnimation09() {

        image09.layer.removeAllAnimations()
        let animation09 = CABasicAnimation(keyPath: "opacity")
        animation09.fromValue = 0
        animation09.toValue = 1
        animation09.duration = 2
        animation09.repeatCount = 1
        animation09.autoreverses = false
        image09.layer.add(animation09, forKey: "09")
        image09.alpha = 1
        
        timer?.invalidate()
        timer = nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(buttonStart)
        view.addSubview(actionView)
        actionView.addSubview(image00)
        actionView.addSubview(image01)
        actionView.addSubview(image02)
        actionView.addSubview(image03)
        actionView.addSubview(image04)
        actionView.addSubview(image05)
        actionView.addSubview(image06)
        actionView.addSubview(image07)
        actionView.addSubview(image08)
        actionView.addSubview(image09)

    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        buttonStart.frame = .init(x: view.bounds.width / 2 - 90, y: view.bounds.height * 0.85, width: 180, height: 44)
        actionView.backgroundColor = .white
        
        setActionViewConstraints()
        placeAllImages()
        setAllImagesAlphaToZero()
    }
    
    func setActionViewConstraints() {
        actionView.translatesAutoresizingMaskIntoConstraints = false
        actionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        actionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        actionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        actionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -130).isActive = true
    }
    
    func placeAllImages() {
        image00.center = actionView.center
        image01.center = actionView.center
        image02.center = actionView.center
        image03.center = actionView.center
        image04.center = actionView.center
        image05.center = actionView.center
        image06.center = actionView.center
        image07.center = actionView.center
        image08.center = actionView.center
        image09.center = actionView.center
    }
    
    func setAllImagesAlphaToZero() {
        image00.alpha = 0
        image01.alpha = 0
        image02.alpha = 0
        image03.alpha = 0
        image04.alpha = 0
        image05.alpha = 0
        image06.alpha = 0
        image07.alpha = 0
        image08.alpha = 0
        image09.alpha = 0
    }
}


