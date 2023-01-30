//
//  ViewController.swift
//  assignment-03
//
//  Created by Dave Regg on 1/30/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var amBackgroundImage: UIImageView!
    @IBOutlet weak var pmBackgroundImage: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var timer = Timer()
    var formatter = DateFormatter()
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        dateLabel.text = formatter.string(from: date)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)
        setBackground()
    }

    @IBAction func buttonPress(_ sender: UIButton) {
        amBackgroundImage.isHidden = !amBackgroundImage.isHidden
        pmBackgroundImage.isHidden = !pmBackgroundImage.isHidden
    }
    
    @objc func tick() {
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        
        dateLabel.text = formatter.string(from: Date())
        setBackground()
    }
    
    func setBackground() {
        let dateComps = Calendar.current.dateComponents([.hour, .day, .weekday, .month], from: Date())
        if dateComps.hour! >= 12 {
            amBackgroundImage.isHidden = true
            pmBackgroundImage.isHidden = false
        } else {
            amBackgroundImage.isHidden = false
            pmBackgroundImage.isHidden = true
        }
    }
    
}

