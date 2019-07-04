//
//  Created by Jaco Sanga on 28/06/2019.
//  Copyright © 2019 Jaco Sanga. All rights reserved.
//



import Foundation
import UIKit
import MapKit


class FavoriCell : UITableViewCell {
    
    @IBOutlet weak private var nom: UILabel!
    @IBOutlet weak private var date: UILabel!
    @IBOutlet weak private var adresse: UILabel!
    @IBOutlet weak private var urgence: UILabel!
    @IBOutlet weak private var niveau: UILabel!
    @IBOutlet weak var panier: UIButton!
    
    var activity: Activity!
    
    func configureWithActivity(_ activity: Activity) {
        self.activity = activity
        
        nom.text = "\(activity.name)"
        date.text = "\(activity.date)"
        adresse.text = "\(activity.address)"
        switch activity.urgence {
        case 1:
            urgence.text = "🔴"
        case 2:
            urgence.text = "🔶"
        case 3:
            urgence.text = "✅"
        default:
            urgence.text = "?"
        }
        switch activity.niveau {
        case 0:
            niveau.text = "🏆"
        case 1:
            niveau.text = "🏆🏆"
        case 2:
            niveau.text = "🏆🏆🏆"
        default:
            niveau.text = "?"
        }

    }
    
    @IBAction func go(_ sender: Any) {
        activity.panier = !activity.panier
        panier.setTitle("Go!", for: .selected)
        panier.setTitle("Annuler", for: .normal)
        panier.setTitleColor(.blue, for: .selected)
        panier.setTitleColor(.black, for: .normal)
        print(activity.panier)
    }

}


class FavorisViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("refresh")
        addActivitiesToFav(allActivities)
    }
    
    func addActivitiesToFav(_ activities: [Activity]) {
        
        allFavoris = allActivities.filter { $0.favori == true }
        tableView.reloadData()
//        allFavoris = []
//        for activity in allActivities {
//            if activity.favori {
//               allFavoris.append(activity)
//            }
//        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFavoris.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriCell", for: indexPath) as! FavoriCell
        let activity = allFavoris[indexPath.row]
        cell.configureWithActivity(activity)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Activités"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activity = allFavoris[indexPath.row]
        print(activity)
    } 
}
