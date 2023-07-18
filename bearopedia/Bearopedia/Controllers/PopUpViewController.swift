//
//  PopUpViewController.swift
//  EvaGoetzke
//
//  Created by Eva Goetzke on 09/03/2022.
//

import UIKit

class PopUpViewController: UIViewController {
    
    var speciesData : Species!
    
    @IBOutlet weak var popUpImage: UIImageView!
    
    @IBOutlet weak var funFactTextView: UITextView!
    
    @IBOutlet weak var popUpPanel: UIView!
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   
        funFactTextView.isScrollEnabled = false
        funFactTextView.sizeToFit()
        funFactTextView.text = speciesData.funFact
        funFactTextView.font = UIFont.boldSystemFont(ofSize: 22.0)
        
        popUpPanel.sizeToFit()
        popUpPanel.layer.masksToBounds = true
        popUpPanel.layer.cornerRadius = 20
    }

}

