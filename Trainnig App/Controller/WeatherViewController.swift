//
//  WeatherViewController.swift
//  Trainnig App
//
//  Created by user on 03.08.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    //instance variables
    let locationManager = CLLocationManager()
    let currentWeather = WeatherDataModel()
    
    //constants
    let URL : String = "http://api.openweathermap.org/data/2.5/weather?"
    let APP_ID = "a8654374899d7bb4c704a365cb8decde"
    
    //IBoutlets
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    //MARK: Networking
    
    func getWeatherData(url: String, parameters : [String : String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success loading JSON")
                let weatherJSON = JSON(response.result.value!)
                self.parsingJSON(json: weatherJSON)
                
            } else {
                print("Error loading JSON \(String(describing: response.result.error))")
            }
        }
        
    }
    
    //MARKL: JSON Parsing
    func parsingJSON(json: JSON){
        
        if let temperatureValue = json["main"]["temp"].double {
            currentWeather.temperature = Int(temperatureValue - 275.15)
            currentWeather.condition = json["weather"][0]["id"].intValue
            currentWeather.humidity = json["main"]["humidity"].intValue
            currentWeather.pressure = json["main"]["pressure"].intValue
            currentWeather.cityName = json["name"].stringValue
            currentWeather.sunSet = json["sys"]["sunset"].doubleValue
            currentWeather.weatherIconName = currentWeather.weatherCondition(condition: currentWeather.condition)
            
            updateWeatherData(weatherData: currentWeather)
            print(currentWeather.condition)
            
        }
    }
    
    //MARK: UpdateUI
    func updateWeatherData(weatherData: WeatherDataModel){
        
        cityLabel.text = "Your current city is: " + currentWeather.cityName
        temperatureLabel.text = temperatureLabel.text! + ": " + String(currentWeather.temperature) + "℃"
        humidityLabel.text = humidityLabel.text! + ": " + String(currentWeather.humidity) + "%"
        pressureLabel.text = pressureLabel.text! + ": " + String(currentWeather.pressure) + "hPa"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let time = Date(timeIntervalSince1970: currentWeather.sunSet)
        
        sunsetLabel.text = "sunset at: " + dateFormatter.string(from: time)
        weatherImg.image = UIImage.init(named: currentWeather.weatherIconName)
        
    }

    //MARK: Location Delegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locations = locations[locations.count - 1]
        if locations.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            let latitude = String(locations.coordinate.latitude)
            let longitude = String(locations.coordinate.longitude)
            let params: [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            getWeatherData(url: URL, parameters: params)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Fail specifying location\(error)")
    }
    
}


























