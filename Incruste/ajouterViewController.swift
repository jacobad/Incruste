//
//  ajouterViewController.swift
//  Incruste
//
//  Created by Jaco Sanga on 28/06/2019.
//  Copyright © 2019 Jaco Sanga. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class ajouterViewController: UITableViewController {
    @IBOutlet weak var sportPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var whereTextField: UITextField!
    @IBOutlet weak var labelLevelCup: UILabel!
    @IBOutlet weak var stepLevel: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //   liste des sports en questions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return sportPicker.selectedRow(inComponent: 8)
    }
    
    //        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //            return sportPicker.selectedRow(inComponent: 0)
    //    }
    
    //  date picker prendere la date
    
    func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        
        
        
        let date = dateFormatter.string(from: datePicker.date)
        
        dateFormatter.dateFormat = "HH:mm MMM dd, YYYY"
        
        print("test: heure et date",date)
        
    }
    //   où prendre l'addresse
    
    
    
    
    func textFieldAddress(_ sender: Any) {
        
        //        let newUser = User(Int(UITextField.value)); trainerSwitch.isOn;)
        //            let newUser = whereTextField.text
        //           append(newUser)
        //
        //        }
        //
        //    func showUserButtonTapped(_ sender: Any) {
        
        //        var addressUser
        
        //            for user in addressUser {
        //                user.describe()
        //            }
        //
        //        }
        // Step bar prednre le niveau de difficulte
        
    func setStepper(_ sender: Any) {
            
            var currentValueLevel = stepLevel.value
            
            
            switch currentValueLevel
                
            {
            case 1:
                currentValueLevel = 0
                labelLevelCup.text = "🏆"
            case 2:
                currentValueLevel = 1
                labelLevelCup.text = "🏆🏆"
            case 3:
                currentValueLevel = 2
                labelLevelCup.text = "🏆🏆🏆"
            default:
                break
            }
        }
        
        //   valide le button prend tout les valeurs de la page et l'envoie à la Map
        
        
    
    }
    
    
    @IBAction func goActivity(_ sender: Any) {
        Activity(sportType: .mma, name: "ROCKY TOURNOI - 🏆", sousTitre: "-", address: "75 Rue Douy Delcupe", date: NSDate(), niveau: 0, urgence: 1, favori: false, panier: false, gps: CLLocationCoordinate2D(latitude: 48.8557, longitude: 2.429139999999961))
                dismiss(animated: true, completion: nil)
    }
    
}
