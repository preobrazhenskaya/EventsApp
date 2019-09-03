//
//  TimeCollectionCell.swift
//  EventsApp
//
//  Created by Яна Преображенская on 01/09/2019.
//  Copyright © 2019 Яна Преображенская. All rights reserved.
//

import UIKit

class TimeCollectionCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    
    var active : Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
