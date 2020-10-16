//
//  ViewController.swift
//  FloatingAlertSheet
//
//  Created by Alexander on 10/15/2020.
//  Copyright (c) 2020 Alexander. All rights reserved.
//

import UIKit
import FloatingAlertSheet

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let yes = FloatingAlertAction.action(icon: nil, title: "Yes") {
            print("yes")
        }
        let no = FloatingAlertAction.actionArrow(icon: nil, title: "no") {
            print("no")
        }
        
        let swi = FloatingAlertAction.actionSwitch(icon: nil, title: "Switch") { (swit) in
            print(swit.isOn)
        }
        
        let alert = FloatingAlertController(icon: nil, title: "This title", action: [yes,no,swi])
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.present(alert, animated: false, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension FloatingAlertController {
    convenience init(icon: UIImage?, title: String, action: [FloatingAlertAction]) {
        self.init()
        self.floatingAlert = action
        self.floatingAlert.insert(.separator, at: 0)
        self.floatingAlert.insert(.title(icon: icon, title: title), at: 0)
    }
}

