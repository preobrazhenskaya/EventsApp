//
//  EventViewController.swift
//  EventsApp
//
//  Created by Яна Преображенская on 23/08/2019.
//  Copyright © 2019 Яна Преображенская. All rights reserved.
//

import UIKit
import Alamofire

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
    @IBOutlet weak var dashedView: UIView!
    @IBOutlet weak var leftSemiCircle: UIView!
    @IBOutlet weak var rightSemiCircle: UIView!
    @IBOutlet weak var leftCircle: UIView!
    @IBOutlet weak var rightCircle: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = event?.name
        drawCircle(circle: leftCircle)
        drawCircle(circle: rightCircle)
        drawSemiCircle(circle: leftSemiCircle, center: CGPoint(x: 0, y: leftSemiCircle.bounds.maxY / 2))
        drawSemiCircle(circle: rightSemiCircle, center: CGPoint(x: rightSemiCircle.bounds.maxX,
                                                                y: rightSemiCircle.bounds.maxY / 2))
        drawDottedLine(line: dashedView)
        setData()
    }
    
    func drawCircle(circle : UIView) {
        circle.backgroundColor = .clear
        let circleLayer = CAShapeLayer()
        let center = CGPoint(x: circle.bounds.maxX / 2, y: circle.bounds.maxY / 2)
        let radius = circle.frame.size.width / 2
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 180,
                                      clockwise: true)
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circle.layer.addSublayer(circleLayer)
    }
    
    func drawSemiCircle(circle : UIView, center : CGPoint) {
        circle.backgroundColor = .clear
        let semiCircleLayer = CAShapeLayer()
        let radius = circle.frame.size.width
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 90,
                                      clockwise: true)
        semiCircleLayer.path = circlePath.cgPath
        semiCircleLayer.fillColor = UIColor(red: 247, green: 248, blue: 249, alpha: 1).cgColor
        circle.layer.addSublayer(semiCircleLayer)
    }
    
    func drawDottedLine(line: UIView) {
        line.backgroundColor = .clear
        let start = CGPoint(x: 0, y: 1)
        let end = CGPoint(x: line.frame.maxX, y: 1)
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3]
        let path = CGMutablePath()
        path.addLines(between: [start, end])
        shapeLayer.path = path
        line.layer.addSublayer(shapeLayer)
    }
    
    func setData() {
        let dFormat = DateFormatter()
        dFormat.dateFormat = "H:mm"
        let start = Date(timeIntervalSince1970: TimeInterval((event?.startDate)!))
        let end = Date(timeIntervalSince1970: TimeInterval((event?.endDate)!))
        startTimeLabel.text = dFormat.string(from: start)
        endTimeLabel.text = dFormat.string(from: end)
        nameLabel.text = event?.authorName
        dFormat.dateFormat = "d MMMM yyyy"
        dateLabel.text = dFormat.string(from: start)
        let hStart = Calendar.current.component(.hour, from: start)
        let mStart = Calendar.current.component(.minute, from: start)
        let interval = end.timeIntervalSince(start)
        let t = Int(interval / 60)
        if t > (1440 - (hStart * 60 + mStart)) {
            timeLabel.text = "-"
            let errorTimeAlert = UIAlertController(title: "Ошибка",
                                                   message: "Неправильное время",
                                                   preferredStyle: .alert)
            errorTimeAlert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
            self.present(errorTimeAlert, animated: true, completion: nil)
        } else {
            let h = t / 60
            let m = t % 60
            var hStr = ""
            if h == 1 {
                hStr = "час"
            } else if h == 2 || h == 3 || h == 4 {
                hStr = "часа"
            } else {
                hStr = "часов"
            }
            if h != 0 {
                timeLabel.text = "\(h) \(hStr) "
            } else {
                timeLabel.text = ""
            }
            if m != 0 {
                timeLabel.text = timeLabel.text! + "\(m) минут"
            }
        }
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
    
    @IBAction func clickCancelButton(_ sender: Any) {
        cancelEvent(id: event?.id)
        setData()
    }
    
    func cancelEvent(id : Int?) {
        if id != nil {
            let url = "http://gt-schedule.profsoft.online/api/event/cancel/\(id!)"
            Alamofire.request(url, method: .get)
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            do {
                                self.event = try JSONDecoder().decode(Event.self, from: data)
                            }
                            catch {
                                print("Can't fetch event")
                            }
                        } else {
                            return
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
            }
        } else {
            let errorAlert = UIAlertController(title: "Ошибка",
                                               message: "Невозможно отменить мероприятие",
                                               preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
        }
    }
}
