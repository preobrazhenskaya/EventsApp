//
//  FiltersVC.swift
//  EventsApp
//
//  Created by Яна Преображенская on 31/08/2019.
//  Copyright © 2019 Яна Преображенская. All rights reserved.
//

import UIKit

class FiltersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedPlaces = [false, false, false]
    
    @IBOutlet weak var filtersTableView: UITableView! {
        didSet {
            filtersTableView.dataSource = self
            filtersTableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Фильтры"
        filtersTableView.register(UINib(nibName: "DateCell", bundle: nil),
                               forCellReuseIdentifier: "DateCell")
        filtersTableView.register(UINib(nibName: "PlaceCell", bundle: nil),
                               forCellReuseIdentifier: "PlaceCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        returnedView.backgroundColor = UIColor(red: 247/255.0, green: 248/255.0, blue: 249/255.0, alpha: 1)
        return returnedView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 3
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 52
        } else if indexPath.section == 1 {
            return 80
        } else {
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
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            for i in 0...(selectedPlaces.count - 1) {
                if selectedPlaces[i] == true {
                    if let placeCell =
                        filtersTableView.cellForRow(at: IndexPath(row: i, section: 1)) as? PlaceCell {
                        placeCell.notCheckButton()
                        selectedPlaces[i] = false
                    }
                }
            }
            if let placeCell = filtersTableView.cellForRow(at: indexPath) as? PlaceCell {
                placeCell.checkButton()
                selectedPlaces[indexPath.row] = true
            }
        }
    }
}
