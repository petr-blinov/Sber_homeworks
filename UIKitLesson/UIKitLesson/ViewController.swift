//
//  ViewController.swift
//  UIKitLesson
//
//  Created by Петр Блинов on 19.05.2021.
//

import UIKit

class ViewController: UIViewController {

//    override func loadView() { }
    
    lazy var infoBlock: InfoBlockView = {
        let view = InfoBlockView(text: "Hello")
        view.backgroundColor = .gray
        return view
    }()
    lazy var gradientView: GradientView = {
        let view = GradientView(frame: .zero)
        return view
    }()
    lazy var tapGesture: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(viewTapped))
        return recognizer
    }()
    lazy var panGesture: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(toPan(sender:)))
        return recognizer
    }()
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ViewController2", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    lazy var circleView: CircleView = {
        let circleView = CircleView(radius: 125)
        circleView.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return circleView
    }()
    lazy var circleHoleView: CircleView = {
        let circleHoleView = CircleView(radius: 75)
        circleHoleView.backgroundColor = .white
        return circleHoleView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(infoBlock)
        view.addSubview(gradientView)
        view.addSubview(button)
        view.addSubview(circleView)
        view.addSubview(circleHoleView)
        
        gradientView.colors = [.yellow, .blue, .green, .brown]
        gradientView.isUserInteractionEnabled = true
        
        gradientView.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(panGesture)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        infoBlock.frame = .init(x: 0, y: 0, width: 200, height: 200)
        infoBlock.center = view.center
        
        gradientView.frame = .init(x: 0, y: 0, width: 300, height: 300)
        gradientView.center = view.center
        
        button.frame = .init(x: view.frame.width / 2 - 75, y: view.frame.height - 200, width: 150, height: 44)
        
        circleView.frame = .init(x: view.frame.width / 2 - 125, y: 600, width: 250, height: 250)
        circleHoleView.frame = .init(x: 0, y: 0, width: 150, height: 150)
        circleHoleView.center = circleView.center

    }
    
    @objc func viewTapped() {
        gradientView.colors = [.red, .orange]
    }
    
    @objc func buttonTapped() {
        navigationController?.pushViewController(SecondViewController(), animated: true)
        //present(SecondViewController(), animated: true, completion: nil)    }
    }
    
    @objc func toPan(sender: UIPanGestureRecognizer) {
        print(sender.translation(in: view))
        let coordinates = sender.translation(in: view)
        gradientView.colors[0] = coordinatesToColor(x: coordinates.x, y: coordinates.y)
        gradientView.colors[1] = coordinatesToColor(x: coordinates.y, y: coordinates.x)
        gradientView.colors[2] = coordinatesToColor(x: coordinates.y/2, y: coordinates.x/2)
        gradientView.colors[3] = coordinatesToColor(x: coordinates.x*2, y: coordinates.y*2)
    }
    private func coordinatesToColor(x: CGFloat, y: CGFloat) -> UIColor {
        return UIColor(red: abs(x / view.frame.width), green: abs(y / view.frame.height), blue: 0.2, alpha: 1)
    }
}
