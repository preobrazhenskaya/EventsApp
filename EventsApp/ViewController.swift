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
    
    @IBOutlet weak var eventTable: UITableView! {
        didSet {
            eventTable.dataSource = self
            eventTable.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTable.register(UINib(nibName: "EventCell", bundle: nil),
                            forCellReuseIdentifier: "EventCell")
        navigationItem.title = self.title!
    }

    @IBAction func AddEventClick(_ sender: Any) {
        let addEventVC = AddEventViewController()
        self.navigationController?.pushViewController(addEventVC, animated: true)
    }
    
    @IBAction func filtersButtonClick(_ sender: Any) {
        let filtersVC = FiltersVC()
        self.navigationController?.pushViewController(filtersVC, animated: true)
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
            eventCell.selectionStyle = .none
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
