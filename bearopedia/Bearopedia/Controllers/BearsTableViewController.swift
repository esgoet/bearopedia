//
//  BearsTableViewController.swift
//  EvaGoetzke
//
//  Created by Eva Goetzke on 25/02/2022.
//

import UIKit

class BearsTableViewController: UIViewController {
    
    // model data
    var bears : Bears!
    var genusNames : [String] = []
    var speciesMatrix : [[Species]] = []
    var favoritedSpecies : [Species] = []
    var genus : String = ""
    var isReordered : Bool = false
    var isBearified : Bool = false
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet var tableView: UITableView!
    
    var isFavoriteSelected = false
    
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // initialise model data with xml file
        bears = Bears(xmlFileName: "ursidae.xml")
        
        for (key, value) in bears.data {
            genusNames.append(key)
            speciesMatrix.append(value)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelectionDuringEditing = true
        tableView.setEditing(true, animated: true)
        
        tabBar.delegate = self
        
        tabBar.selectedItem = tabBar.items?[0]
        tabBar.unselectedItemTintColor = UIColor(named: "ThemeColor")
        
        let favoritedNotification = NSNotification.Name("favorited")
        NotificationCenter.default.addObserver(self, selector: #selector(speciesWasFavorited(notification:)) , name: favoritedNotification, object: nil)
        
        let bearifiedNotification = NSNotification.Name("bearified")
        NotificationCenter.default.addObserver(self, selector: #selector(appWasBearified(notification:)) , name: bearifiedNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @objc func speciesWasFavorited (notification: Notification) {
        if let species = (notification.object as? Species) {
            if isFavoriteSelected {
                favoritedSpecies[species.indexPath.row].isFavorited = species.isFavorited
                if !species.isFavorited {
                    tableView.reloadData()
                }
            } else {
                speciesMatrix[species.indexPath.section][species.indexPath.row].isFavorited = species.isFavorited
            }
        }
    }
    
    @objc func appWasBearified (notification: Notification) {
        if let isBearified = (notification.object as? Bool) {
            self.isBearified = isBearified
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // check the segue id
         if segue.identifier == "segue01", let destinationController = segue.destination as? ViewController, let species = sender as? Species {
             
             destinationController.speciesData = species
         }
        
        if segue.identifier == "seguePopUp01", let destinationController = segue.destination as? SettingsPopUpViewController {
            destinationController.isBearified = self.isBearified
        }
        
        
     }
}

extension BearsTableViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 1 {
            isFavoriteSelected = true
        } else {
            isFavoriteSelected = false
        }
        tableView.reloadData()
    }
}
    
extension BearsTableViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if isFavoriteSelected {
            return 1
        } else {
            return genusNames.count
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFavoriteSelected {
            favoritedSpecies.removeAll()
            
            for species in speciesMatrix.joined() {
                if species.isFavorited {
                    favoritedSpecies.append(species)
                }
            }
            
            if favoritedSpecies.count != 0 {
                return favoritedSpecies.count
            } else {
                return 1
            }
        } else {
            return speciesMatrix[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomTableViewCell {
            
            if isFavoriteSelected {
                if !favoritedSpecies.isEmpty {
                    let speciesData = favoritedSpecies[indexPath.row]
                    if speciesData.isFavorited {
                        speciesData.indexPath = indexPath
                        cell.speciesData = speciesData
                        cell.isBearified = self.isBearified
                        cell.loadCell()
                        cell.rankLabel.text = String((indexPath.row+1))
                        cell.rankLabel.textColor = UIColor.white
                        cell.rankLabel.backgroundColor = UIColor(named: "AccentColor")
                        return cell
                    }
                } else {
                    let defaultCell = UITableViewCell()
                    var content = defaultCell.defaultContentConfiguration()
                    
                    content.textProperties.color = UIColor(named: "LabelColor")!
                    
                    content.textProperties.font = UIFont.preferredFont(forTextStyle: .subheadline)

                    // Configure content.
                    let txt = "No favourites yet :("
                    
                    content.text = txt.uppercased()
                    
                    content.textProperties.alignment = .center


                    defaultCell.contentConfiguration = content
                    
                    defaultCell.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
                    
                    return defaultCell
                }
            } else {
                let speciesData = speciesMatrix[indexPath.section][indexPath.row]
               
                speciesData.indexPath = indexPath
                cell.speciesData = speciesData
                // Configure the cell...
                cell.isBearified = self.isBearified
                cell.loadCell()
                cell.rankLabel.text = ""
                cell.rankLabel.backgroundColor = UIColor.clear
                    
                return cell
            }
        }
        //need to add something for when no bears have been favourited yet
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !isFavoriteSelected {
            performSegue(withIdentifier: "segue01", sender: speciesMatrix[indexPath.section][indexPath.row])
        } else {
            performSegue(withIdentifier: "segue01", sender: favoritedSpecies[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if isFavoriteSelected && !favoritedSpecies.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        for cell in self.tableView.visibleCells as! [CustomTableViewCell]  {
            var indexPath = self.tableView.indexPath(for: cell)!
            if sourceIndexPath.row > destinationIndexPath.row {
                if indexPath.row >= destinationIndexPath.row && indexPath.row < sourceIndexPath.row {
                    indexPath.row += 1
                    cell.speciesData?.indexPath = indexPath
                    cell.rankLabel.text = String((indexPath.row + 1))
                } else if indexPath.row == sourceIndexPath.row {
                    cell.speciesData?.indexPath = destinationIndexPath
                    cell.rankLabel.text = String((destinationIndexPath.row + 1))
                }
            } else {
                if indexPath.row > sourceIndexPath.row && indexPath.row <= destinationIndexPath.row {
                    indexPath.row -= 1
                    cell.speciesData?.indexPath = indexPath
                    cell.rankLabel.text = String((indexPath.row + 1))
                } else if indexPath.row == sourceIndexPath.row {
                    cell.speciesData?.indexPath = destinationIndexPath
                    cell.rankLabel.text = String((destinationIndexPath.row + 1))
                }
            }
        }
        
    }
}
    
    
extension BearsTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !isFavoriteSelected {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear

            let sectionLabel = UILabel(frame: CGRect(x: 18, y: 10, width:
                tableView.bounds.size.width, height: tableView.bounds.size.height))
            sectionLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
            sectionLabel.textColor = UIColor.gray
            sectionLabel.text = genusNames[section].uppercased()
            sectionLabel.sizeToFit()
            headerView.addSubview(sectionLabel)
            
            return headerView
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
