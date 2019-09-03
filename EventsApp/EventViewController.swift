//
//  EventViewController.swift
//  EventsApp
//
//  Created by Яна Преображенская on 23/08/2019.
//  Copyright © 2019 Яна Преображенская. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    var event : Event?

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = event?.name
        let dFormat = DateFormatter()
        dFormat.dateFormat = "H:mm"
        let start = Date(timeIntervalSince1970: TimeInterval((event?.startDate)!))
        let end = Date(timeIntervalSince1970: TimeInterval((event?.endDate)!))
        startTimeLabel.text = dFormat.string(from: start)
        endTimeLabel.text = dFormat.string(from: end)
        nameLabel.text = event?.authorName
        dFormat.dateFormat = "d MMMM yyyy"
        dateLabel.text = dFormat.string(from: start)
        phoneNumberLabel.text = event?.authorPhone
        placeLabel.text = "Зал \((event?.room)!)"
        var status = ""
        if event?.status == 0 {
            status = "Новый"
        } else if event?.status == 1 {
            status = "Подтвержден"
        } else if event?.status == 2 {
            status = "Отменен"
        }
        statusLabel.text = status
        descriptionLabel.text = event?.comment
    }
}
