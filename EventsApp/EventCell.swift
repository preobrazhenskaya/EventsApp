//
//  EventCell.swift
//  EventsApp
//
//  Created by Яна Преображенская on 20/08/2019.
//  Copyright © 2019 Яна Преображенская. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameAndPhoneLabel: UILabel!
    @IBOutlet weak var statusPic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
