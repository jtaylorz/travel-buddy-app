//
//  tripTypePicker.swift
//  LoginWindow
//
//  Created by Elan Kainen on 4/29/18.
//  Copyright © 2018 Wen, Jason. All rights reserved.
//

import UIKit

class tripTypePicker: UIPickerView {

    var tripData: [TripType]!

}

extension tripTypePicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tripData.count;
    }
    
    
}
extension tripTypePicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent
        component: Int) -> String? {
        return tripData[row].type 
    }
    
}
