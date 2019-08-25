//
//  ViewController.swift
//  EventsApp
//
//  Created by Яна Преображенская on 20/08/2019.
//  Copyright © 2019 Яна Преображенская. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTable.register(UINib(nibName: "EventCell", bundle: nil),
                            forCellReuseIdentifier: "EventCell")
    }

    @IBOutlet weak var eventTable: UITableView! {
        didSet {
            eventTable.dataSource = self
            eventTable.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let eventCell = tableView.dequeueReusableCell(withIdentifier: "EventCell",
                                                             for: indexPath) as? EventCell {
            return eventCell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventVC = EventViewController()
        self.navigationController?.pushViewController(eventVC, animated: true)
    }
}
