//
//  annotation.swift
//  txtF_V
//
//  Created by Céline Duflo on 28/06/2019.
//  Copyright © 2019 Jeffrey Cheminelle. All rights reserved.
//

import UIKit
import MapKit

enum SportType {
    case foot
    case basket
    case tennis
    case golf
    case rugby
    case mma
}


struct Activity {
    let sportType: SportType
    let name: String
    let address: String
    let niveau: Int
    var urgence: Int
    var favori: Bool
    var panier: Bool
    let gps: CLLocationCoordinate2D
}

class ActivityAnnotation: NSObject, MKAnnotation {
    
    let activity: Activity
    init(activity: Activity) {
        self.activity = activity
    }
    var coordinate: CLLocationCoordinate2D {
        return activity.gps
    }
    var title: String? {
        return activity.name
    }
    
}





