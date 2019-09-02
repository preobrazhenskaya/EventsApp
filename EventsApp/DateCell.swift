//
//  DateCell.swift
//  EventsApp
//
//  Created by Яна Преображенская on 28/08/2019.
//  Copyright © 2019 Яна Преображенская. All rights reserved.
//

import UIKit

class DateCell: UITableViewCell {
    
    @IBOutlet weak var dateInput: UITextField!
    
    let datePicker = UIDatePicker()
    var parentTimeCell : TimeCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        parentTimeCell?.timeInput.text?.removeAll()
        dateInput.inputView = datePicker
        datePicker.datePickerMode = .date
        let language = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: language!)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                         action: #selector(doneAction))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil,
                                    action: nil)
        toolbar.setItems([space, doneButton], animated: true)
        dateInput.inputAccessoryView = toolbar
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @objc func doneAction() {
        getDateFromDatePicker()
        endEditing(true)
    }
    
    func getDateFromDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        dateInput.text = formatter.string(from: datePicker.date)
    }
}
