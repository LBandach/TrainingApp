//
//  WeatherDataModel.swift
//  Trainnig App
//
//  Created by user on 07.08.2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation

class WeatherDataModel {
    
    var temperature: Int = 0
    var condition: Int = 0
    var humidity: Int = 0
    var pressure: Int = 0
    var sunSet: Double = 0
    var cityName: String = ""
    var weatherIconName: String = ""
    
    
    func weatherCondition(condition: Int) -> String {
        
        switch (condition) {
        case 200...232 :
            return "11d"
        case 300...321 :
            return "9d"
        case 500...531 :
            return "10d"
        case 600...622 :
            return "13d"
        case 701...781 :
            return "50d"
        case 800 :
            return "01d"
        case 801 :
            return "02d"
        case 802 :
            return "03d"
        case 803...804 :
            return "04d"
        default :
            return "Dunno"
        }
    }
}
