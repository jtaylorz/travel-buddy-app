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
    var tripPicker: tripTypePicker!
    @IBOutlet weak var textfield: UITextField!
    
    public var identityId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tripPicker = tripTypePicker as! tripTypePicker?
        tripPicker.tripData = Type.getType()
        
        tripTypePicker.delegate = tripPicker
        tripTypePicker.dataSource = tripPicker
        
        showSignIn()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutButtonPress(_ sender: Any) {
        AWSSignInManager.sharedInstance().logout(completionHandler: {(result: Any?, error: Error?) in
            self.showSignIn()
            // print("Sign-out Successful: \(signInProvider.getDisplayName)");
            
        })
        
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

