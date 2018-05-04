//
//  TripObj.swift
//  MySampleApp
//
//
// Copyright 2018 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to 
// copy, distribute and modify it.
//
// Source code generated from template: aws-my-sample-app-ios-swift v0.21
//

import Foundation
import UIKit
import AWSDynamoDB

class TripObj: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _createdDate: NSNumber?
    var _destination: String?
    var _endDate: NSNumber?
    var _expectedCost: NSNumber?
    var _length: NSNumber?
    var _name: String?
    var _notes: String?
    var _numCommitted: NSNumber?
    var _numParticipants: NSNumber?
    var _startDate: NSNumber?
    var _type: String?
    
    class func dynamoDBTableName() -> String {

        return "travelbuddyapp-mobilehub-1128196265-TripObj"
    }
    
    class func hashKeyAttribute() -> String {

        return "_createdDate"
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
               "_createdDate" : "createdDate",
               "_destination" : "destination",
               "_endDate" : "endDate",
               "_expectedCost" : "expectedCost",
               "_length" : "length",
               "_name" : "name",
               "_notes" : "notes",
               "_numCommitted" : "numCommitted",
               "_numParticipants" : "numParticipants",
               "_startDate" : "startDate",
               "_type" : "type",
        ]
    }
}