//  FirstViewController.swift
//  Work Smart
//
//  Created by Will Langas on 1/8/19.
//  Copyright © 2019 Will Langas. All rights reserved.

import UIKit
import SQLite3
import Foundation

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak var Picker: UIPickerView!
    
     let classes = ["Elective","Engineering","English","Foreign Language","History", "Math", "Science","Break","Other"]
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        
        let date = Date.init(timeIntervalSinceNow: 86400)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let dateString = dateFormatter.string(from: date)
        
        dateLabel.text = dateString
        
        Picker.delegate = self
        Picker.dataSource = self
        
        setGradientBackground() //Leave this in in case image view fails. If not a problem, we can take this out
        
        super.viewDidLoad()
        
        title = "Track"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        pauseButton.isEnabled = false //Turn pause button "off"
    
    }
    
    func numberOfComponents(in Picker: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ Picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return classes.count
    }
    
    func pickerView(_ Picker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return classes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let str = classes[row]
        return NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    var seconds = 0
    var timer = Timer() //Create a timer object
    
    var isTimerRunning = false //Reset timer values/properties
    var resumeTapped = false
    
    //MARK: - IBActions
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isTimerRunning == false {
            self.resumeTapped = false
            runTimer() //Begin timer action, defined after this function
            self.startButton.isEnabled = false //"Turn off" start button
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FirstViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        pauseButton.isEnabled = true
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate() //Pauses timer (in conjunction with next line)
            isTimerRunning = false
            self.resumeTapped = true
            self.pauseButton.setTitle("Resume",for: .normal) //When pause button is pressed, the button switches to say "Resume" in a smaller font
            pauseButton.titleLabel?.font =  UIFont(name: "SFCompactDisplay-Thin", size: 25)
        } else {
            runTimer()
            self.resumeTapped = false
            isTimerRunning = true
            self.pauseButton.setTitle("Pause",for: .normal)
            pauseButton.titleLabel?.font =  UIFont(name: "SFCompactDisplay-Thin", size: 30)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        seconds = 0
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        pauseButton.isEnabled = false //Reset everything back to initial defaults
        startButton.isEnabled = true
        
        //Uncomment runTimer and isTimerRunning if you want the timer to automatically start again when reset
        //runTimer()
        self.resumeTapped = false
        //isTimerRunning = true
        self.pauseButton.setTitle("Pause",for: .normal)
        pauseButton.titleLabel?.font =  UIFont(name: "SFCompactDisplay-Thin", size: 30)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Success", message: "Your homework has been logged", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    @objc func updateTimer() {
        if seconds < 0 {
            timer.invalidate()
            //Send alert to indicate time's up.
        } else {
            seconds += 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
            //            labelButton.setTitle(timeString(time: TimeInterval(seconds)), for: UIControlState.normal)
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    //This is the basic three color gradient for the background. It is only still in the code just in case there are issues with the image view. It is only a backup that possibly will be removed in testing.
    func setGradientBackground() {
        let colorTop =  UIColor(red:0.35, green:0.73, blue:0.92, alpha:1.0).cgColor
        let colorMiddle = UIColor(red:0.52, green:0.81, blue:0.92, alpha:1.0).cgColor
        let colorBottom = UIColor(red:0.53, green:0.38, blue:0.82, alpha:1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorMiddle, colorBottom]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
