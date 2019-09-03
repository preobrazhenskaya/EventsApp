//
//  AddEventViewController.swift
//  EventsApp
//
//  Created by Яна Преображенская on 27/08/2019.
//  Copyright © 2019 Яна Преображенская. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var parsedData : [Event]?
    var filterData : [Event] = []
    var selectedPlaces = [false, false, false]
    var returnDate : Date?
    
    @IBOutlet weak var addEventTable: UITableView! {
        didSet {
            addEventTable.dataSource = self
            addEventTable.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Забронировать"
        addEventTable.register(UINib(nibName: "DateCell", bundle: nil),
                               forCellReuseIdentifier: "DateCell")
        addEventTable.register(UINib(nibName: "PlaceCell", bundle: nil),
                               forCellReuseIdentifier: "PlaceCell")
        addEventTable.register(UINib(nibName: "TimeCell", bundle: nil),
                               forCellReuseIdentifier: "TimeCell")
        addEventTable.register(UINib(nibName: "ContactCell", bundle: nil),
                               forCellReuseIdentifier: "ContactCell")
        addEventTable.register(UINib(nibName: "DescriptionCell", bundle: nil),
                               forCellReuseIdentifier: "DescriptionCell")
        addEventTable.register(UINib(nibName: "BookNowCell", bundle: nil),
                               forCellReuseIdentifier: "BookNowCell")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        returnedView.backgroundColor =
            UIColor(red: 247/255.0, green: 248/255.0, blue: 249/255.0, alpha: 1)
        return returnedView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 2 || section == 4 {
            return 1
        } else if section == 1 || section == 3 {
            return 3
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 52
        case 1:
            return 80
        case 2:
            return 52
        case 3:
            if indexPath.row == 2 {
                return 142
            } else {
                return 65
            }
        case 4:
            return 69
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let dateCell = tableView.dequeueReusableCell(withIdentifier: "DateCell",
                                                         for: indexPath) as? DateCell {
                dateCell.selectionStyle = .none
                dateCell.accessoryType = .disclosureIndicator
                return dateCell
            } else {
                return UITableViewCell()
            }
        case 1:
            if let placeCell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell",
                                                             for: indexPath) as? PlaceCell {
                placeCell.selectionStyle = .none
                if indexPath.row == 0 {
                    placeCell.placeLabel.text = "Зал 1"
                    placeCell.placePic.image = UIImage(named: "place1")
                } else if indexPath.row == 1 {
                    placeCell.placeLabel.text = "Зал 2"
                    placeCell.placePic.image = UIImage(named: "place2")
                } else if indexPath.row == 2 {
                    placeCell.placeLabel.text = "Зал 3"
                    placeCell.placePic.image = UIImage(named: "place3")
                }
                return placeCell
            } else {
                return UITableViewCell()
            }
        case 2:
            if let timeCell = tableView.dequeueReusableCell(withIdentifier: "TimeCell",
                                                            for: indexPath) as? TimeCell {
                timeCell.selectionStyle = .none
                timeCell.accessoryType = .disclosureIndicator
                return timeCell
            } else {
                return UITableViewCell()
            }
        case 3:
            if indexPath.row == 0 || indexPath.row == 1 {
                if let contactCell = tableView.dequeueReusableCell(withIdentifier: "ContactCell",
                                                             for: indexPath) as? ContactCell {
                    contactCell.selectionStyle = .none
                    if indexPath.row == 0 {
                        contactCell.informationInput.placeholder = "Имя"
                        contactCell.informationIcon.image = UIImage(systemName: "person")
                    } else if indexPath.row == 1 {
                        contactCell.informationInput.placeholder = "Телефон"
                        contactCell.informationIcon.image = UIImage(systemName: "lock")
                    }
                    return contactCell
                } else {
                    return UITableViewCell()
                }
            } else if indexPath.row == 2 {
                if let descriptionCell =
                    tableView.dequeueReusableCell(withIdentifier: "DescriptionCell",
                                                  for: indexPath) as? DescriptionCell {
                    descriptionCell.selectionStyle = .none
                    return descriptionCell
                } else {
                    return UITableViewCell()
                }
            } else {
                return UITableViewCell()
            }
        case 4:
            if let bookCell = tableView.dequeueReusableCell(withIdentifier: "BookNowCell",
                                                            for: indexPath) as? BookNowCell {
                bookCell.selectionStyle = .none
                return bookCell
            } else {
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if let timeCell = addEventTable.cellForRow(at: IndexPath(row: 0, section: 2)) as? TimeCell {
                timeCell.timeInput.text?.removeAll()
            }
        } else if indexPath.section == 1 {
            for i in 0...(selectedPlaces.count - 1) {
                if selectedPlaces[i] == true {
                    if let placeCell =
                        addEventTable.cellForRow(at: IndexPath(row: i, section: 1)) as? PlaceCell {
                        placeCell.notCheckButton()
                        selectedPlaces[i] = false
                    }
                }
            }
            if let placeCell = addEventTable.cellForRow(at: indexPath) as? PlaceCell {
                placeCell.checkButton()
                selectedPlaces[indexPath.row] = true
            }
        } else if indexPath.section == 2 {
            if let dateCell = addEventTable.cellForRow(at: IndexPath(row: 0, section: 0)) as? DateCell {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat =  "d MMM yyyy"
                returnDate = dateFormatter.date(from: dateCell.dateInput.text!)
                if returnDate != nil && selectedPlaces.contains(true) {
                    returnDate = returnDate!.addingTimeInterval(5.0 * 60.0 * 60.0)
                    let dReturnDate = Calendar.current.component(.day, from: returnDate!)
                    let mReturnDate = Calendar.current.component(.month, from: returnDate!)
                    let yReturnDate = Calendar.current.component(.year, from: returnDate!)
                    for i in 0...((parsedData?.count)! - 1) {
                        let eventTime =
                            Date(timeIntervalSince1970: TimeInterval((parsedData?[i].startDate)!))
                        let dEventTime = Calendar.current.component(.day, from: eventTime)
                        let mEventTime = Calendar.current.component(.month, from: eventTime)
                        let yEventTime = Calendar.current.component(.year, from: eventTime)
                        if dReturnDate == dEventTime
                            && mReturnDate == mEventTime
                            && yReturnDate == yEventTime
                            && "\((selectedPlaces.firstIndex(of: true))! + 1)" == parsedData?[i].room {
                            filterData.append((parsedData?[i])!)
                        }
                    }
                    let timeVC = TimeVC()
                    timeVC.events = filterData
                    self.navigationController?.pushViewController(timeVC, animated: true)
                } else if returnDate == nil && !(selectedPlaces.contains(true)) {
                    let errorAlert = UIAlertController(title: "Ошибка",
                                                       message: "Выберите время и место",
                                                       preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
                    self.present(errorAlert, animated: true, completion: nil)
                } else if returnDate == nil {
                    let errorAlert = UIAlertController(title: "Ошибка",
                                                           message: "Выберите время",
                                                           preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
                    self.present(errorAlert, animated: true, completion: nil)
                } else if !(selectedPlaces.contains(true)) {
                    let errorAlert = UIAlertController(title: "Ошибка",
                                                           message: "Выберите место",
                                                           preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
                    self.present(errorAlert, animated: true, completion: nil)
                }
            }
        }
    }
}
