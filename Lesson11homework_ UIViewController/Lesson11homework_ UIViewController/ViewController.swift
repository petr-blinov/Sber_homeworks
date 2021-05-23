//
//  ViewController.swift
//  Lesson11homework_ UIViewController
//
//  Created by Петр Блинов on 22.05.2021.
//

import UIKit

//Домашнее задание
//Реализовать кнопку share (UIActivityViewController)
//Исключить PostToFlickr, PostToVimeo, SaveToCameraRoll
//Обработать остальные
//Реализовать 1 любую свою UIActivity

class ViewController: UIViewController {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "iMac")
        return imageView
    }()
    
    lazy var shareButton: UIButton = {
        let shareButton = UIButton(type: .system)
        shareButton.setTitle("Share", for: .normal)
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.titleLabel?.textAlignment = .center
        shareButton.backgroundColor = .systemBlue
        shareButton.layer.cornerRadius = 10
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return shareButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(shareButton)
    }

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setImageViewConstraints()
        setButtonConstraints()
    }
    
    func setImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: view.frame.width - 20).isActive = true
    }
    
    func setButtonConstraints() {
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        shareButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        shareButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    @objc func shareButtonTapped() {
       
        let image = imageView.image
        let customActivity = CustomActivity()
        
        let activityViewController = UIActivityViewController(activityItems: [image as Any], applicationActivities: [customActivity])
        
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.postToFlickr, UIActivity.ActivityType.postToVimeo, UIActivity.ActivityType.saveToCameraRoll]

        present(activityViewController, animated: true, completion: nil)
    }
}

