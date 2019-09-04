//
//  TimeVC.swift
//  EventsApp
//
//  Created by Яна Преображенская on 01/09/2019.
//  Copyright © 2019 Яна Преображенская. All rights reserved.
//

import UIKit

class TimeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let blueTimeColor = UIColor(displayP3Red: 0.18, green: 0.56, blue: 0.96, alpha: 1)
    var events : [Event]!
    var minutes = 30
    var selectedCells : [Int] = []
    var busyTime : [Int] = []
    
    @IBOutlet weak var timeCollection: UICollectionView! {
        didSet {
            timeCollection.dataSource = self
            timeCollection.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Выбрать время"
        let readyButton = UIBarButtonItem(title: "Готово", style: .plain, target: self,
                                          action: #selector(readyClick))
        self.navigationItem.rightBarButtonItem  = readyButton
        timeCollection.register(UINib(nibName: "TimeCollectionCell", bundle: nil),
                                forCellWithReuseIdentifier: "TimeCollectionCell")
        if events.count > 0 {
            doBusyTimesArray()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 49
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let timeCollectionCell =
            timeCollection.dequeueReusableCell(withReuseIdentifier: "TimeCollectionCell",
                                               for: indexPath) as? TimeCollectionCell {
            let cellTime = minutes * indexPath.row
            if busyTime.contains(cellTime) {
                timeCollectionCell.active = false
                timeCollectionCell.backgroundColor = .lightGray
            } else {
                timeCollectionCell.active = true
                timeCollectionCell.backgroundColor = .white
            }
            timeCollectionCell.timeLabel.text =
            "\(cellTime / 60 < 24 ? cellTime / 60 : 0):\(cellTime % 60 == 0 ? 0 : 3)0"
            return timeCollectionCell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectCell = timeCollection.cellForItem(at: indexPath) as? TimeCollectionCell {
            if selectCell.active! {
                if selectedCells.count == 2 {
                    selectedCells.removeAll()
                    changeColorToWhite()
                }
                selectedCells.append(indexPath.row)
                if selectedCells.count == 2 && selectedCells[0] >= selectedCells[1] {
                    selectedCells.removeAll()
                    changeColorToWhite()
                } else {
                    changeColorToBlue()
                }
            }
        }
    }
    
    func changeColorToBlue() {
        for i in (selectedCells[0])...selectedCells[selectedCells.count - 1] {
            if let selectCell =
                timeCollection.cellForItem(at: IndexPath(row: i, section: 0)) as? TimeCollectionCell {
                if !selectCell.active! {
                    changeColorToWhite()
                    return
                }
            }
        }
        for i in (selectedCells[0])...selectedCells[selectedCells.count - 1] {
            if let selectCell =
                timeCollection.cellForItem(at: IndexPath(row: i, section: 0)) as? TimeCollectionCell {
                selectCell.backgroundColor = blueTimeColor
                selectCell.timeLabel.textColor = .white
            }
        }
    }
    
    func changeColorToWhite() {
        let cellsCount = timeCollection.numberOfItems(inSection: 0)
        for i in 0...(cellsCount - 1) {
            if let selectCell =
                timeCollection.cellForItem(at: IndexPath(row: i, section: 0)) as? TimeCollectionCell {
                if selectCell.backgroundColor == blueTimeColor {
                    selectCell.backgroundColor = .white
                    selectCell.timeLabel.textColor = .black
                }
            }
        }
    }
    
    @objc func readyClick() {
        if selectedCells.count < 2 {
            let errorTimeAlert = UIAlertController(title: "Ошибка",
                                                   message: "Неправильно выбрано время",
                                                   preferredStyle: .alert)
            errorTimeAlert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
            self.present(errorTimeAlert, animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
            let countView = navigationController?.viewControllers.count
            if let prevVC =
                navigationController?.viewControllers[countView! - 1] as? AddEventViewController {
                if let timeCell =
                    prevVC.addEventTable.cellForRow(at: IndexPath(row: 0, section: 2)) as? TimeCell {
                    if let startTime =
                        timeCollection.cellForItem(at: IndexPath(row: selectedCells[0], section: 0))
                            as? TimeCollectionCell,
                        let endTime =
                        timeCollection.cellForItem(at: IndexPath(row: selectedCells[1], section: 0))
                            as? TimeCollectionCell {
                        timeCell.timeInput.text = "\(startTime.timeLabel.text!) - \(endTime.timeLabel.text!)"
                    }
                }
            }
        }
    }
    
    func doBusyTimesArray() {
        for i in 0...(events.count - 1) {
            let startTime = Date(timeIntervalSince1970: TimeInterval(events[i].startDate!))
            let endTime = Date(timeIntervalSince1970: TimeInterval(events[i].endDate!))
            let mStartTime = Calendar.current.component(.minute, from: startTime)
                + Calendar.current.component(.hour, from: startTime) * 60
            let mEndTime = Calendar.current.component(.minute, from: endTime)
                + Calendar.current.component(.hour, from: endTime) * 60
            for j in stride(from: mStartTime, to: mEndTime, by: 30) {
                busyTime.append(j)
            }
        }
    }
}
