//
//  ViewController.swift
//  txtF_V
//
//  Created by Jeffrey Cheminelle on 24/06/2019.
//  Copyright © 2019 Jeffrey Cheminelle. All rights reserved.
//

// ---DEBUG GPS
// ---CHOISIR UNE AUTRE COULEUR QUE LE ROUGE POUR LES ACTIVITES URGENTES?
// ---CONFIG POUR LES SPORTS
// DECIDER POUR LES FAVORIS
// DEPLACER LA CONVERSION GPS OU IL FAUT
// TESTER EN CREANT UNE PROPOSITION
// DISPLAY UN PANIER OU DES FAVORIS
// CLICK SUR UN POINT --> AFFICHER EN DETAIL ET METTRE DANS SON PANIER OU FAV
// DEPUIS LE PANIER OU FAVORIS CHOISIR/RETIRER UNE ACTIVITE
// DEPUIS LE PANIER OU FAVORIS CHOISIR/RETIRER UN FAVORI
// VIDER DU PANIER A QUEL MOMENT?

import UIKit
import MapKit // import du kit Map
import CoreLocation // import du core de localisation

class ViewController: UIViewController {
    let locationManager = CLLocationManager() // initialisation du manager de localisation
    
    
    //POUR TESTER L'OVERLAY
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //INIT LA LOCATION
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters // Distance de la précision de la localisation
        locationManager.delegate = self // appel des fonctions mise plus bas ->
        locationManager.requestWhenInUseAuthorization() // demande l'autorisation à l'utilisateur, voir le fichier "info.plist"
        locationManager.startUpdatingLocation() //démarre la localisation
        
        mapView.delegate = self
        // DOIT ETRE INITIALISE DANS CONTROLLER DES PROPOSITIONS (1 et 2):
        
        // 1- TR FROM ADDRESS TO GPS A APPELER QUAND ON CREE LES PROPOSITIONS:
        
        var activities = [Activity]()
        var urgence : Int
        
        let type = SportType.foot
        let name = "Formation foot"
        let address = "55 avenue de Vincennes, Montreuil"
        //        let difference = pickerDate.date.timeIntervalSinceNow
        let difference = 8000 // en attendant
        if difference < 7200 {
            urgence = 1
        }
        else if (difference >= 7200 && difference <= 21600) {
            urgence = 2
        }
        else {
            urgence = 3
        }
        
        //        getLocation(from: address) { location in
        //
        //            //print("Location is", location.debugDescription)
        //            print("Location is \(location!.latitude) - \(location!.longitude)")
        //            let lat = location!.latitude
        //            let long = location!.longitude
        //            let activity = Activity(sportType: type,
        //                                name: name,
        //                                address: address,
        //                                niveau: 2,
        //                                urgence: urgence,
        //                                favori: false,
        //                                panier: false,
        //                                gps: CLLocationCoordinate2D(latitude: lat, longitude: long))
        
        //            append the activities in array
        //
        //        }
        
        // 2- REMPLIR AU FUR ET A MESURE QU'ON CREE LES PROPOSITIONS ou vider si on les delete:
        activities = [ Activity(sportType: .foot, name: "Formation foot", sousTitre: "Test", address: "55 avenue de montreuil", niveau: 2, urgence: 3, favori: false, panier: false, gps: CLLocationCoordinate2D(latitude: 48.859858726171105, longitude: 2.436545)),
                       
                       Activity(sportType: .basket, name: "vvvv", sousTitre: "Tes2", address: "31 avenue de l'opera", niveau: 2, urgence: 2, favori: false, panier: false, gps: CLLocationCoordinate2D(latitude: 48.854607, longitude: 2.4333))
        ]
        
        
        //POUR TESTER L'OVERLAY
        let activite = activities [0]
        
        // LES AFFICHER - LA MAP RECOIT JUSTE UN ARRAY (AVEC UN SEGUE)?
        loadActivitiesOnMap(activities: activities)
        
    }
    
    func processActivity(_ activity: Activity) {
        
    }
    
    
    func getLocation(from address: String, completion: @escaping (_ location: CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
                let location = placemarks.first?.location?.coordinate else {
                    return
            }
            completion(location)
        }
    }
    
    func loadActivitiesOnMap(activities: [Activity]) {
        let activityList = activities.map { (activity) in
            return ActivityAnnotation(activity: activity)
        }
        mapView.addAnnotations(activityList)
        mapView.showAnnotations(mapView.annotations, animated: true)

    }
    
}

extension ViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation)-> MKAnnotationView? {
        
        if let annotation = annotation as? ActivityAnnotation {
            
            let identifier = "toto"
            var marker = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if marker == nil {
                marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                marker!.canShowCallout = true
                
                
                func timeColor(){
                    //COULEUR EN FONCTION DE L'URGENCE
                    switch annotation.activity.urgence {
                    case 1: // 2h
                        marker!.markerTintColor = .red
                    case 2: // 2h-4h
                        marker!.markerTintColor = .orange
                    case 3: // 6h
                        marker!.markerTintColor = .green
                    default: marker!.markerTintColor = .white
                    }
                    //COULEUR DU SPORT EN FONCTION DU FAVORITE OR NOT
                    if annotation.activity.favori {
                        marker!.glyphTintColor = .blue }
                    else {
                        marker!.glyphTintColor = .white
                    }
                }
                
                switch annotation.activity.sportType {
                case .foot :
                    let photoProfil = UIImage(named: "football")
                    let photoProfilView = UIImageView(image: photoProfil)
                    photoProfilView.contentMode = .scaleAspectFill
                    marker!.glyphImage = photoProfil
                    timeColor()
                //                return markerMapSport
                case .basket :
                    let photoProfil = UIImage(named: "basket")
                    let photoProfilView = UIImageView(image: photoProfil)
                    photoProfilView.contentMode = .scaleAspectFill
                    marker!.glyphImage = photoProfil
                    timeColor()
                //                return markerMapSport
                case .tennis:
                    let photoProfil = UIImage(named: "tennis")
                    let photoProfilView = UIImageView(image: photoProfil)
                    photoProfilView.contentMode = .scaleAspectFill
                    marker!.glyphImage = photoProfil
                    timeColor()
                //                return markerMapSport
                case .rugby:
                    let photoProfil = UIImage(named: "rugby")
                    let photoProfilView = UIImageView(image: photoProfil)
                    photoProfilView.contentMode = .scaleAspectFill
                    marker!.glyphImage = photoProfil
                    timeColor()
                case .golf:
                    let photoProfil = UIImage(named: "ski")
                    let photoProfilView = UIImageView(image: photoProfil)
                    photoProfilView.contentMode = .scaleAspectFill
                    marker!.glyphImage = photoProfil
                    timeColor()
                case .mma:
                    let photoProfil = UIImage(named: "mma")
                    let photoProfilView = UIImageView(image: photoProfil)
                    photoProfilView.contentMode = .scaleAspectFill
                    marker!.glyphImage = photoProfil
                    timeColor()
                }
                
            } else {
                marker!.annotation = annotation
            }
            let imageFavori = UIImage(named: "favori")
            let btn = UIButton(type: .custom)
                btn.setImage(imageFavori, for: .normal)
            let sizeFavori = CGSize(width: 30, height: 30)
                btn.frame = CGRect(origin: .zero, size: sizeFavori)
                marker!.rightCalloutAccessoryView = btn

//            marker!.leftCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            return marker
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("🤓", view)
    }
}


// L'extension est créer pour
extension ViewController : CLLocationManagerDelegate {
    // fonction qui permet de prendre les donnée de localité
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last!
        
        if let location = locations.first {
            let spanUser = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
            let region = MKCoordinateRegion(center: location.coordinate, span: spanUser)
            mapView.setRegion(region, animated: true)
            mapView.showsUserLocation = true
            mapView.showsTraffic = true
            mapView.showsPointsOfInterest = false
            mapView.showsScale = false
            mapView.showsBuildings = false
            print("loca : \(location)")
            //            toto.text = String("\(location.coordinate)")
        }
    }
    
    //fonction pour avoir le statu de l'autorisation de la localisation
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}


