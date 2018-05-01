//
//  ViewController.swift
//  LoginWindow
//
//  Created by Wen, Jason on 4/4/18.
//  Copyright © 2018 Wen, Jason. All rights reserved.
//

import UIKit

import AWSMobileClient
import AWSAuthCore
import AWSAuthCore
import AWSAuthUI

class ViewController: UIViewController {
    
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var tripTypePicker: UIPickerView!
    var menuShowing = false
    @IBOutlet weak var textfield: UITextField!
    
    public var identityId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSignIn()
        
    }
    
    @IBAction func signOutButton(_ sender: UIButton) {
        AWSSignInManager.sharedInstance().logout(completionHandler: {(result: Any?, error: Error?) in
            self.showSignIn()
            // print("Sign-out Successful: \(signInProvider.getDisplayName)");
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showSignIn() {
        AWSAuthUIViewController.presentViewController(with: self.navigationController!, configuration: nil, completionHandler: {
            (provider: AWSSignInProvider, error: Error?) in
            if error != nil {
                print("Error occurred: \(String(describing: error))")
            } else {
                print("Sign-in successful.")
                
            }
        })
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

