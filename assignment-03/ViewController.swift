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
    @IBOutlet weak var timerButton: UIButton!
    
    var timeLeft: Int?
    var clock = Timer()
    var timer = Timer()
    var formatter = DateFormatter()
    var date = Date()
    var isTimerOn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        dateLabel.text = formatter.string(from: date)
        clock = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)
        timeRemainingLabel.isHidden = true
        timerButton.setTitle("Start Timer", for: .normal)
        setBackground()
    }

    @IBAction func buttonPress(_ sender: UIButton) {
        timer.invalidate()
        timeRemainingLabel.isHidden = false
        // Convert datePicker.countdownduration into HH:MM:SS
        // Concat to label2
        timeRemainingLabel.text = "Time Remaining: " + stringFromTimeInterval(interval: datePicker.countDownDuration)
        
        // Create a Timer for the countdown
        timeLeft = Int(datePicker.countDownDuration)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startCountdown), userInfo: nil, repeats: true)
        
        // Ensure that User cannot interact with Picker after button press
        datePicker.isUserInteractionEnabled = false
    }
    
    @objc func tick() {
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        
        dateLabel.text = formatter.string(from: Date())
        setBackground()
    }
    
    @objc func startCountdown() {
        if timeLeft! >= 0 {
            timeRemainingLabel.text = "Time Remaining: " + stringFromTimeInterval(timeLeft: timeLeft!)
            timeLeft! -= 1
        } else {
            // Invalid timer
            timer.invalidate()
        }
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
    
    func stringFromTimeInterval(interval: TimeInterval = 0.0, timeLeft: Int = 0) -> String {
        let time: Int
        if (interval != 0.0) {
            time = Int(interval)
        } else {
            time = timeLeft
        }
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
}

