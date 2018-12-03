//
//  WeatherModel.swift
//  TempNow
//
//  Created by Chen Wang on 11/28/18.
//  Copyright © 2018 utopia incubator. All rights reserved.
//

import Foundation

class WeatherModel {
    
    //Declare your model variables here
    var CTemp : Int = 0
    var FTemp : Int = 0
    var condition : Int = 0
    var city : String = ""
    var weatherIconName : String = ""
    
    //A3D4F7     cloud
    //60A2D7     rain
    
    //This method turns a condition code into the name of the weather condition image
    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...232:
            return "008-storm-1"
        
        case 300...499:
            return "013-rainy"
            
        case 500...504:
            return "005-cloudy-2"
            
        case 505...531:
            return "013-rainy"
            
        case 600...610 :
            return "007-snowy"
            
        case 611...612:
            return "011-snowy-1"
            
        case 613...620 :
            return "007-snowy"
            
        case 701...781:
            return "009-windy"
        
            
        case 800 :
            return "001-sun"
            
        case 801:
            return "002-cloudy"
            
        case 802:
            return "003-cloud"
            
        case 803...804:
            return "004-cloudy-1"
            
            
        default :
            return "001-sun"
        }
        
    }
}

