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
    
    var parsedData : [Event]?
    var filtersDate : Date?
    var filtersPlace : Int?
    var filtersDateData : [Event] = []
    var filtersPlaceData : [Event] = []
    
    @IBOutlet weak var eventTable: UITableView! {
        didSet {
            eventTable.dataSource = self
            eventTable.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = self.title!
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        eventTable.register(UINib(nibName: "EventCell", bundle: nil),
                            forCellReuseIdentifier: "EventCell")
        fetchEvents()
    }

    @IBAction func AddEventClick(_ sender: Any) {
        let addEventVC = AddEventViewController()
        addEventVC.parsedData = parsedData
        self.navigationController?.pushViewController(addEventVC, animated: true)
    }
    
    @IBAction func filtersButtonClick(_ sender: Any) {
        let filtersVC = FiltersVC()
        self.navigationController?.pushViewController(filtersVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtersPlaceData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let eventCell = tableView.dequeueReusableCell(withIdentifier: "EventCell",
                                                             for: indexPath) as? EventCell {
            eventCell.selectionStyle = .none
            let dFormat = DateFormatter()
            dFormat.dateFormat = "H:mm"
            let time = Date(timeIntervalSince1970: TimeInterval((filtersPlaceData[indexPath.row].startDate)!))
            eventCell.timeLabel.text = dFormat.string(from: time)
            eventCell.nameLabel.text = filtersPlaceData[indexPath.row].name
            eventCell.nameAndPhoneLabel.text =
                (filtersPlaceData[indexPath.row].authorName)! + ", " + (filtersPlaceData[indexPath.row].authorPhone)!
            var statusPic = ""
            var statusColor : UIColor = .white
            if filtersPlaceData[indexPath.row].status == 0 {
                statusPic = "questionmark.square"
                statusColor = .yellow
            } else if filtersPlaceData[indexPath.row].status == 1 {
                statusPic = "checkmark.square"
                statusColor = .green
            } else if filtersPlaceData[indexPath.row].status == 2 {
                statusPic = "xmark.square"
                statusColor = .red
            }
            eventCell.statusPic.image = UIImage(systemName: statusPic)
            eventCell.statusPic.tintColor = statusColor
            return eventCell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventVC = EventViewController()
        eventVC.event = filtersPlaceData[indexPath.row]
        self.navigationController?.pushViewController(eventVC, animated: true)
    }
    
    func fetchEvents() {
        let url = "http://gt-schedule.profsoft.online/api/event"
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            self.parsedData = try JSONDecoder().decode([Event].self, from: data)
                            DispatchQueue.main.async {
                                self.filtersPlaceData = self.parsedData ?? []
                                self.eventTable.reloadData()
                            }
                        }
                        catch {
                            print("Can't fetch parsedData")
                        }
                    } else {
                        return
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
    func filtrationByDate() {
        for i in 0...((parsedData?.count)! - 1) {
            let eventDate = Date(timeIntervalSince1970: TimeInterval((parsedData?[i].startDate)!))
            let dFiltersDate = Calendar.current.component(.day, from: filtersDate!)
            let mFiltersDate = Calendar.current.component(.month, from: filtersDate!)
            let yFiltersDate = Calendar.current.component(.year, from: filtersDate!)
            let dEventDate = Calendar.current.component(.day, from: eventDate)
            let mEventDate = Calendar.current.component(.month, from: eventDate)
            let yEventDate = Calendar.current.component(.year, from: eventDate)
            if dFiltersDate == dEventDate && mFiltersDate == mEventDate && yFiltersDate == yEventDate {
                filtersDateData.append((parsedData?[i])!)
            }
        }
    }
    
    func filtrationByPlace() {
        for i in 0...(filtersDateData.count - 1) {
            if "\(filtersPlace!)" == filtersDateData[i].room {
                filtersPlaceData.append(filtersDateData[i])
            }
        }
    }
    
    func reloadWithFilters() {
        if filtersDate != nil {
            filtersDateData = []
            filtrationByDate()
        } else {
            filtersDateData = parsedData!
        }
        if filtersPlace != nil && filtersDateData.count > 0 {
            filtersPlaceData = []
            filtrationByPlace()
        } else {
            filtersPlaceData = filtersDateData
        }
        eventTable.reloadData()
    }
}
