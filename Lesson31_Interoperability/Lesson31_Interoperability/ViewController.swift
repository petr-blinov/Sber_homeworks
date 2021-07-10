//
//  ViewController.swift
//  Lesson31_Interoperability
//
//  Created by Petr Blinov on 11.07.2021.
//

import UIKit
import ObjCLibModule

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        
        let objCLib = ObjCLib()
        let objCSubLib = objCLib.objCSubLib
    }
}

