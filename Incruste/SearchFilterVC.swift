//
//  ViewController.swift
//  Incruste
//
//  Created by Jaco Sanga on 28/06/2019.
//  Copyright © 2019 Jaco Sanga. All rights reserved.
//

import UIKit

class SearchFilterVC: UITableViewController {

    @IBOutlet weak var football: UITableViewCell!
    @IBOutlet weak var basket: UITableViewCell!
    @IBOutlet weak var tennis: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return true
        } else {
            return false
        }
    }
    @IBAction func doneClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        let cell = tableView.cellForRow(at: indexPath)!
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
        }
    }
}




class Activite {
    enum Sports {
        case football (String)
        case basketball (String)
        case tennis (String)
        case sportsdecombat (String)
        case golf (String)
        case ski (String)
    }
}
