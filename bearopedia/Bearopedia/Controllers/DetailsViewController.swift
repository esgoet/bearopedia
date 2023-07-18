//
//  DetailsViewController.swift
//  EvaGoetzke
//
//  Created by Eva Goetzke on 25/02/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //model data
    var detailsData : Species!
    
    //outlets and actions

    @IBOutlet weak var commonNameLabel: UILabel!
    
    @IBOutlet weak var scientificNameLabel: UILabel!
    
    @IBOutlet weak var dietLabel: UILabel!
    
    @IBOutlet weak var webButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var habitatPanel: UIView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet var detailPanels: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self

        for panel in detailPanels {
            panel.backgroundColor = UIColor(hue: 0.27, saturation: 0.7, brightness: 0.4, alpha: 1.0)
            panel.layer.masksToBounds = true
            panel.layer.cornerRadius = 20
        }
        
        webButton.backgroundColor = UIColor(hue: 0.27, saturation: 0.69, brightness: 0.69, alpha: 1.0)
        
       
        let numberOfHabitats : Int = detailsData.habitats.count
        
        if numberOfHabitats > 1 {
            heightConstraint.constant = CGFloat(37+(numberOfHabitats * 59))
        }
     

        //populate the outlets
        commonNameLabel.text = detailsData.commonName
        scientificNameLabel.text = detailsData.scientificName
        dietLabel.text = detailsData.diet

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue03" {
            //get the destination controller
            let destinationController = segue.destination as! WebBrowserViewController
            
            //push the data
            destinationController.speciesData = self.detailsData
        }
    }
}

extension DetailsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsData.habitats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "habitatCell") {
            var content = cell.defaultContentConfiguration()
            
            content.textProperties.color = UIColor(white: 1.0, alpha: 1.0)
            
            content.textProperties.font = UIFont.preferredFont(forTextStyle: .title1)

            // Configure content.
            content.text = detailsData.habitats[indexPath.row]


            cell.contentConfiguration = content
            
            cell.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
            
            return cell
        }
        
        return UITableViewCell()
        
    }
    
}

