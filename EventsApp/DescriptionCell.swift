//
//  DescriptionCell.swift
//  EventsApp
//
//  Created by Яна Преображенская on 30/08/2019.
//  Copyright © 2019 Яна Преображенская. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {

    @IBOutlet weak var descriptionInput: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        let centeredParagraphStyle = NSMutableParagraphStyle()
//        centeredParagraphStyle.alignment = .center
//        let attributedPlaceholder = NSAttributedString(string: "Описание мероприятия", attributes: [NSAttributedString.Key.paragraphStyle: centeredParagraphStyle])
//        descriptionInput.attributedPlaceholder = attributedPlaceholder
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
