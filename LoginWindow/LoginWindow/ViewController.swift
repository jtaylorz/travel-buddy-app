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
    
//    let interests = ["hiking", "biking", "sightseeig", "kayaking", "surfing"]
    
    
    @IBOutlet weak var interestText: UILabel!
    
    @IBOutlet weak var statusBar: UITextField!
    
    @IBOutlet weak var newStatus: UILabel!

    @IBOutlet weak var newInt: UITextField!
    // MARK: Actions
    
   
    @IBAction func changeInterest(_ sender: Any) {
        interestText.text = newInt.text
        
        newInt.isHidden = true
    }
    
    @IBAction func postStatus(_ sender: Any) {
        
        newStatus.text = statusBar.text
        newStatus.isHidden = false
        statusBar.isHidden = true
        
//        if statusBar.isHidden == true{
//            statusBar.isHidden = false
//        }
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
    @IBOutlet weak var numParticipantsField: UITextField!
    @IBOutlet weak var expectedCostField: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    
    // MARK: Actions
    @IBAction func createTrip(_ sender: UIButton) {
        saveTrip(name : tripNameField.text, type : tripTypeField.text, destination : tripDestinationField.text, numParticipants : numParticipantsField.text, expectedCost : expectedCostField.text, startDate : startDatePicker.date, endDate : endDatePicker.date)
        tripNameField.text = ""
        tripTypeField.text = ""
        tripDestinationField.text = ""
        numParticipantsField.text = ""
        expectedCostField.text = ""
    }
    
    func saveTrip(name : String?, type : String?, destination : String?, numParticipants : String?, expectedCost : String?, startDate: Date?, endDate: Date?) {
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
        tripItem._numParticipants = (numParticipants as! NSString).integerValue as! NSNumber
        tripItem._numCommitted = 1
        tripItem._expectedCost = (expectedCost as! NSString).integerValue as! NSNumber
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
    
    // MARK: Properties
    @IBOutlet weak var queryField: UITextField!
    
    @IBOutlet weak var queriedTripName: UILabel!
    
    
    // MARK: Actions
    @IBAction func searchButtonPress(_ sender: UIButton) {
        let tripName = queryTrip(creationDateQuery: queryField.text)
        queriedTripName.text = tripName
    }
    
    
    func queryTrip(creationDateQuery: String?) -> String? {
        // 1) Configure the query
        let queryExpression = AWSDynamoDBQueryExpression()
        queryExpression.keyConditionExpression = "createdDate = :_createdDate"
        
        let queryNSNum = (creationDateQuery as! NSString).doubleValue as! NSNumber
        
        queryExpression.expressionAttributeValues = [
            ":_createdDate": queryNSNum
        ]
        
        // 2) Make the query
        
        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
        
        dynamoDbObjectMapper.query(TripObj.self, expression: queryExpression) { (output: AWSDynamoDBPaginatedOutput?, error: Error?) in
            if error != nil {
                print("The request failed. Error: \(String(describing: error))")
            }
            if output != nil {
                print("In IF")
                for trip in output!.items {
                    let tripItem = trip as? TripObj
                    print("Trip Name: \(tripItem!._name!)")
                    print("Trip Type: \(tripItem!._type!)")
                    print("Trip Destination: \(tripItem!._destination!)")
                    print("Trip Cost: $\(tripItem!._expectedCost!)")
                }
            }
        }
        return "Test"
    }
    
    
//    func readItem() {
//        let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
//
//        // Create adata object using the data models downloaded from Mobile Hub
//        let tripItem: TripObj = TripObj();
//        tripItem._createdDate = AWSIdentityManager.default().identityId
//
//        dynamoDbObjectMapper.load(
//            TripObj.self,
//            hashKey : tripItem._createdDate,
//            rangeKey : "",
//            completionHandler : {
//                (objectModel : AWSDynamoDBObjectModel?, error : Error?) -> Void in
//                if let error = error {
//                    print("Amazon DynamoDB Read Error: \(error)")
//                    return
//                }
//                print("An item was read")
//        })
//    }
    
    
    
}
