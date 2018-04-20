//
//  ViewController.swift
//  LoginWindow
//
//  Created by Wen, Jason on 4/4/18.
//  Copyright © 2018 Wen, Jason. All rights reserved.
//

import UIKit

class ViewController: UIViewController {



    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!

    
    var menuShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func openMenu(_ sender: Any) {
        
        if (menuShowing){
            leadingConstraint.constant = -140
        }
        else{
            leadingConstraint.constant = 0
        }
        
        menuShowing = !menuShowing
    }
    
}

