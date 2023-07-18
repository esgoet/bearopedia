//
//  ViewController.swift
//  EvaGoetzke
//
//  Created by Eva Goetzke on 25/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    //model data - communication link with the model
    var speciesData : Species!
    
    //outlets and actions - communication between views and controller
    
    @IBOutlet weak var speciesImageView: UIImageView!
    
    @IBOutlet weak var bearView: UIView!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var detailsButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var funFactButton: UIButton!
    
    //@IBOutlet weak var funFactLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var funFactView: UIView!
    
    @IBAction func likeAction(_ sender: UIButton) {
        if let speciesData = self.speciesData {
            speciesData.isFavorited = speciesData.isFavorited ? false : true
            if speciesData.isFavorited {
                likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            let notificationName = NSNotification.Name("favorited")
            NotificationCenter.default.post(name: notificationName, object: speciesData)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        detailsButton.layer.masksToBounds = true
        detailsButton.layer.cornerRadius = 20
        
        funFactButton.layer.masksToBounds = true
        funFactButton.layer.cornerRadius = 20
        //speciesImageView.layer.masksToBounds = true
       //speciesImageView.layer.cornerRadius = 20
        bearView.layer.masksToBounds = true
        bearView.layer.cornerRadius = 20
       
        //populate the views
        nameLabel.text = speciesData.commonName
        speciesImageView.image = UIImage(named: speciesData.image)        
        
        
        if speciesData.isFavorited {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // check the segue id
        if segue.identifier == "segue02" {
            //get the destination controller
            let destinationController = segue.destination as! DetailsViewController
            
            //push the data
            destinationController.detailsData = self.speciesData
        }
        
        if segue.identifier == "seguePopUp01" || segue.identifier == "seguePopUp02" {
            //get the destination controller
            let destinationController = segue.destination as! PopUpViewController
            
            //push the data
            destinationController.speciesData = self.speciesData
        }
    }
    
    


}

