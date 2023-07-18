//
//  SettingsPopUpViewController.swift
//  EvaGoetzke
//
//  Created by Eva Goetzke on 19/03/2022.
//

import UIKit

class SettingsPopUpViewController: UIViewController {
    
    var isBearified : Bool!
    
    @IBOutlet weak var settingsView: UIView!
    
    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var bearifySwitch: UISwitch!
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func themeAction(_ sender: Any) {
        if themeSegmentedControl.selectedSegmentIndex == 0 {
            view.window!.overrideUserInterfaceStyle = .light
        } else {            
            view.window!.overrideUserInterfaceStyle = .dark
        }
    }
    
    
    @IBAction func bearifyAction(_ sender: Any) {
        if bearifySwitch.isOn {
            isBearified = true
           
            let notificationName = NSNotification.Name("bearified")
            NotificationCenter.default.post(name: notificationName, object: isBearified)
        } else {
            isBearified = false
            let notificationName = NSNotification.Name("bearified")
            NotificationCenter.default.post(name: notificationName, object: isBearified)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.overrideUserInterfaceStyle = .dark

        // Do any additional setup after loading the view.
        settingsView.layer.masksToBounds = true
        settingsView.layer.cornerRadius = 20
        
        if isBearified {
            bearifySwitch.isOn = true
        }
        
        if traitCollection.userInterfaceStyle == .dark {
            themeSegmentedControl.selectedSegmentIndex = 1
        } else {
            themeSegmentedControl.selectedSegmentIndex = 0
        }
        
    }
    
}
