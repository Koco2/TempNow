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
    
    //This method turns a condition code into the name of the weather condition image
    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            return "storm1"
            
        case 301...600 :
            return "rainy"
            
        case 601...700 :
            return "snowy"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "storm2"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy1"
            
        case 900...903, 905...1000  :
            return "stom2"
            
        case 903 :
            return "snowy"
            
        case 904 :
            return "sunny"
            
        default :
            return "dunno"
        }
        
    }
}

