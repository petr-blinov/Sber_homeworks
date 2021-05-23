//
//  CustomActivity.swift
//  Lesson11homework_ UIViewController
//
//  Created by Петр Блинов on 22.05.2021.
//

import UIKit

class CustomActivity: UIActivity {
    
    override class var activityCategory: UIActivity.Category { .share }
    override var activityType: UIActivity.ActivityType? { .none }
    override var activityTitle: String? { "CustomActivity" }

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
         true
    }
    override var activityViewController: UIViewController? {
        let alertController = UIAlertController(title: "Done", message: "Some custom action has been done", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Great", style: .default) { [weak self] _ in
            self?.activityDidFinish(true)
        }
        alertController.addAction(action)
        return alertController
    }
}
