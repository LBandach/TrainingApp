//
//  CoreLocationViewController.swift
//  Trainnig App
//
//  Created by user on 03.08.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import CoreLocation

class CoreLocationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locations = locations[locations.count - 1]
        if locations.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            longitudeLabel.text = "longitude: \(locations.coordinate.longitude)"
            latitudeLabel.text = "latitude: \(locations.coordinate.latitude)"
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
