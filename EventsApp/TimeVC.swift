//
//  TimeVC.swift
//  EventsApp
//
//  Created by Яна Преображенская on 01/09/2019.
//  Copyright © 2019 Яна Преображенская. All rights reserved.
//

import UIKit

class TimeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var minutes = 3
    var selectedCells : [Int] = []
    
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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 49
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let timeCollectionCell =
            timeCollection.dequeueReusableCell(withReuseIdentifier: "TimeCollectionCell",
                                               for: indexPath) as? TimeCollectionCell {
            let cellTime = minutes * indexPath.row
            timeCollectionCell.timeLabel.text =
                "\(cellTime / 6 < 24 ? cellTime / 6 : 0):\(cellTime % 6)0"
            return timeCollectionCell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
    
    func changeColorToBlue() {
        for i in (selectedCells[0])...selectedCells[selectedCells.count - 1] {
            if let selectCell = timeCollection.cellForItem(at: IndexPath(row: i, section: 0)) as? TimeCollectionCell {
                selectCell.backgroundColor = UIColor(displayP3Red: 0.18, green: 0.56, blue: 0.96, alpha: 1)
                selectCell.timeLabel.textColor = .white
            }
        }
    }
    
    func changeColorToWhite() {
        let cellsCount = timeCollection.numberOfItems(inSection: 0)
        for i in 0...(cellsCount - 1) {
            if let selectCell = timeCollection.cellForItem(at: IndexPath(row: i, section: 0)) as? TimeCollectionCell {
                selectCell.backgroundColor = .white
                selectCell.timeLabel.textColor = .black
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
}
