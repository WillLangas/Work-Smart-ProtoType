//  SecondViewController.swift
//  Work Smart
//
//  Created by Will Langas on 1/8/19.
//  Copyright © 2019 Will Langas. All rights reserved.

import UIKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak var Picker2: UIPickerView! //Create picker object
    
    @IBOutlet weak var textField: UITextField! //Input field
    @IBOutlet weak var stepper: UIStepper! //Picker object
    
    @IBOutlet weak var dateLabel2: UIImageView!
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        textField.text = Int(sender.value).description
    }
    
    let classes = ["Elective","Engineering","English","Foreign Language","History", "Math", "Science","Break","Other"]
    
    override func viewDidLoad() {
        
        Picker2.delegate = self
        Picker2.dataSource = self
        
        setGradientBackground()
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.minimumValue = -360
        stepper.maximumValue = 360
        
        super.viewDidLoad()
        title = "Manual Track"
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfComponents(in Picker2: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ Picker2: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return classes.count
    }
    
    func pickerView(_ Picker2: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return classes[row]
    }
    
    func pickerView(_ Picker2: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let str = classes[row]
        return NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Success", message: "Your homework has been logged", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
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
