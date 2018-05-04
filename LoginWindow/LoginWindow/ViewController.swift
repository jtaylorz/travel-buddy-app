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
import AWSDynamoDB

class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var tripTypePicker: UIPickerView!
    var menuShowing = false
    @IBOutlet weak var textfield: UITextField!
    
    public var identityId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSignIn()
        
    }
    
    // MARK: Actions
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


class TripCreationViewController : UIViewController {
    
    // MARK: Properties    
    @IBOutlet weak var tripNameField: UITextField!
    @IBOutlet weak var tripTypeField: UITextField!
    @IBOutlet weak var tripDestinationField: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    
    // MARK: Actions
    @IBAction func createTrip(_ sender: UIButton) {
        saveTrip(name : tripNameField.text, type : tripTypeField.text, destination : tripDestinationField.text, startDate : startDatePicker.date, endDate : endDatePicker.date )
    }
    
    func saveTrip(name : String?, type : String?, destination : String?, startDate: Date?, endDate: Date?) {
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        // Create data object using data models you downloaded from Mobile Hub
        let tripItem: TripObj = TripObj()
        
        tripItem._name = name
        tripItem._type = type
        tripItem._destination = destination
        tripItem._startDate = (startDate as! NSDate).timeIntervalSince1970 as NSNumber
        tripItem._endDate = (endDate as! NSDate).timeIntervalSince1970 as NSNumber
        tripItem._createdDate = NSDate().timeIntervalSince1970 as NSNumber
        tripItem._length = 1
        tripItem._numParticipants = 20
        tripItem._numCommitted = 1
        tripItem._expectedCost = 1
        tripItem._notes = "Some notes..."
        
        //Save a new item
        dynamoDbObjectMapper.save(tripItem, completionHandler: {
            (error: Error?) -> Void in
            
            if let error = error {
                print("Amazon DynamoDB Save Error: \(error)")
                return
            }
            print("Item was saved.")
        })
        
    }
    
}

class TripSelectionViewController : UIViewController {
    
}
