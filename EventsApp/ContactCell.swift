//
//  ContactCell.swift
//  EventsApp
//
//  Created by Яна Преображенская on 28/08/2019.
//  Copyright © 2019 Яна Преображенская. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var informationInput: UITextField!
    @IBOutlet weak var informationIcon: UIImageView!
    @IBOutlet weak var underlineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        informationIcon.tintColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func click(_ sender: Any) {
        underlineView.backgroundColor = UIColor(red: 0.18, green: 0.56, blue: 0.96, alpha: 1)
    }
    
    @IBAction func clickInside(_ sender: Any) {
        underlineView.backgroundColor = .clear
    }
}
