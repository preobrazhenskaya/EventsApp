//
//  PlaceCell.swift
//  EventsApp
//
//  Created by Яна Преображенская on 28/08/2019.
//  Copyright © 2019 Яна Преображенская. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {

    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var placePic: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    
    let checkedImage = UIImage(systemName: "circle.fill")
    let notChekedImage = UIImage(systemName: "circle")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        radioButton.setImage(notChekedImage, for: .normal)
        radioButton.tintColor = UIColor(red: 0.89, green: 0.9, blue: 0.9, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func checkButton() {
        radioButton.setImage(checkedImage, for: .normal)
        radioButton.tintColor = UIColor(red: 0.18, green: 0.56, blue: 0.96, alpha: 1)
    }
    
    func notCheckButton() {
        radioButton.setImage(notChekedImage, for: .normal)
        radioButton.tintColor = UIColor(red: 0.89, green: 0.9, blue: 0.9, alpha: 1)
    }
}
