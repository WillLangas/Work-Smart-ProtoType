//  FourthViewController.swift
//  Work Smart
//
//  Created by Will Langas on 1/8/19.
//  Copyright © 2019 Will Langas. All rights reserved.


import UIKit

class FourthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradientBackground()
        
        title = "Data"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
