//
//  CustomTableViewCell.swift
//  EvaGoetzke
//
//  Created by Eva Goetzke on 25/02/2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var commonNameLabel: UILabel!
    
    @IBOutlet weak var scientificNameLabel: UILabel!
    
    @IBOutlet weak var bearImage: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var rankLabel: UILabel!
    
    var speciesData: Species?
    var isBearified : Bool!
    var bearBg : UIView = UIView()
    
    func heartSetUp() {
        if let speciesData = self.speciesData {
            if speciesData.isFavorited {
                likeButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(scale: .medium)), for: .normal)
            } else {
                likeButton.setImage(UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(scale: .medium)),  for: .normal)
            }
        }
    }
    
    
    @IBAction func likeAction(_ sender: Any) {
        if let speciesData = self.speciesData {
            speciesData.isFavorited = speciesData.isFavorited ? false : true
           
            let nsName = NSNotification.Name("favorited")
            NotificationCenter.default.post(name: nsName, object: speciesData)
            }
        
        heartSetUp()
    }
    
    func loadCell() {
        heartSetUp()
        
        if let speciesData = self.speciesData {
            commonNameLabel?.text = speciesData.commonName
            scientificNameLabel?.text = speciesData.scientificName
            bearImage?.image = UIImage(named: speciesData.image)
        }
        
        if isBearified {
            resetBearification()
            bearify()
        } else {
            resetBearification()
        }
        
    }
    
    func bearify() {
        bearImage.layer.cornerRadius = 0
        let maskForImage = UIImageView(frame: CGRect(x: 0, y: 0, width: bearImage.frame.size.width, height: bearImage.frame.size.height))
        maskForImage.image = UIImage(named: "bearwithoutshadow.png")
        
        bearImage.mask = maskForImage
        
        bearBg = UIView(frame: bearImage.frame.insetBy(dx: -3, dy: -3))
        let maskForBorder = UIImageView(frame: CGRect(x: 0, y: 0, width: bearBg.frame.size.width, height: bearBg.frame.size.height))
        maskForBorder.image = UIImage(named: "bearwithoutshadow.png")
        bearBg.mask = maskForBorder
        bearBg.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
       
        super.addSubview(bearBg)
        super.sendSubviewToBack(bearBg)
    }
    
    func resetBearification() {
        bearImage.mask = nil
        bearBg.removeFromSuperview()
        bearImage.layer.cornerRadius = 15
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        let bgView = UIView()
        bgView.backgroundColor = UIColor(named: "DarkGreen")
        self.selectedBackgroundView = bgView
        
    }

}
