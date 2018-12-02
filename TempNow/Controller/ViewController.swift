//
//  ViewController.swift
//  TempNow
//
//  Created by Chen Wang on 11/30/18.
//  Copyright © 2018 utopia incubator. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation
import Alamofire
import SwiftyJSON


class ViewController: UIViewController,  CLLocationManagerDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "fe22b230a925754c43d8f74638aff6c3"
    var CFSign = "°C"
    var CorF = false
    
    
    var background:UIImageView!
    var contentView:UIView!
    var controllerSwitch:UIButton!
    var tempLabel:UILabel!
    var weatherIcon:UIImageView!
    var CtoF:UISwitch!
    var cityLabel:UILabel!
    
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherModel()
    

//    override func viewWillAppear(_ animated: Bool) {
//        let params : [String:String] = ["q":UserInput.sharedInstance, "appid":APP_ID]
//        getWeatherData(url: WEATHER_URL, parameters: params)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        
        addBackGroundImage()
        addButtons()
        addSwitch()
        createDisplayView()
        addConstrains()
        print()
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getWeatherData(url:String, parameters:[String:String])
    {
        Alamofire.request(url, method:.get, parameters:parameters).responseJSON
            {
                response in
                if response.result.isSuccess
                {
                    print("Success! Got the weather data!")
                    let weatherJSON : JSON = JSON(response.result.value!)
                    //print(weatherJSON)
                    self.updateWeatherData(json:weatherJSON)
                }
                else
                {
                    print("Error \(String(describing: response.result.error))")
                    self.cityLabel.text = "Connecting Issue"
                }
        }
    }
    
    //MARK: - UI Updates
    /***************************************************************/
    func updateUIWithWeatherData()
    {
        cityLabel.text = weatherDataModel.city
        tempLabel.text = "\(weatherDataModel.temperature)\(CFSign)"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        
    }
    
    
    
    
    //Write the updateUIWithWeatherData method here:
    func updateWeatherData(json:JSON)
    {
        if let tempResult = json["main"]["temp"].double
        {
            
            weatherDataModel.temperature = Int(tempResult - 273.15)
            if CorF
            {
                weatherDataModel.temperature = Int(Double(weatherDataModel.temperature)*1.8+32)
            }
            
            weatherDataModel.city = json["name"].stringValue
            
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
            updateUIWithWeatherData()
            
        }
        else
        {
            cityLabel.text = "Weather Unavaible"
        }
    }
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0
        {
            locationManager.stopUpdatingLocation()
        }
        let longtitude = String(location.coordinate.longitude)
        let latitude = String(location.coordinate.latitude)
        let params : [String: String] = ["lat":latitude,"lon":longtitude,"appid":APP_ID]
        
        getWeatherData(url:WEATHER_URL,parameters: params)
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location unavailable"
    }
    
    
    
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
//    //Write the userEnteredANewCityName Delegate method here:
//    func userEnterANewCityName(city: String) {
//        let params : [String:String] = ["q":city, "appid":APP_ID]
//        getWeatherData(url: WEATHER_URL, parameters: params)
//    }
//
//
//    //Write the PrepareForSegue Method here
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "changeCityName"
//        {
//            let destinationVC = segue.destination as! SearchController
//            destinationVC.delegate = self
//        }
//    }
    
    
    
    
    
    
    
    
    
    
    
    //MARK: UI implementation
    
    private func addBackGroundImage(){
        background = UIImageView(image: UIImage(named: "background1"))
        background.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.addSubview(background);
    }
    
    private func addButtons(){
        controllerSwitch = UIButton()
        controllerSwitch.setBackgroundImage(UIImage(named: "switch"), for: .normal)
        controllerSwitch.addTarget(self, action: #selector(controllerSwitchPressed), for: .touchUpInside)
        self.view.addSubview(controllerSwitch)
        
    }
    
    @objc private func controllerSwitchPressed(){        
        self.present(SearchController(), animated: true, completion: nil)
    }
    
    private func addSwitch(){
        CtoF = UISwitch()
        CtoF.addTarget(self, action: #selector(switchPressed(_:)), for: .valueChanged)
        self.view.addSubview(CtoF)
    }
    
    @objc private func switchPressed(_ sender:UISwitch){
        if sender.isOn
        {
            CorF = false
            CFSign = "°C"
        }
        else
        {
            CorF = true
            CFSign = "°F"
        }
        locationManager.startUpdatingLocation()
    }
    
    private func createDisplayView(){
        contentView = UIView()
        contentView.isUserInteractionEnabled = true
        //contentView.backgroundColor = UIColor.orange
        self.view.addSubview(contentView)
        
        tempLabel = UILabel()
        tempLabel.text = "21°C"
        //tempLabel.backgroundColor = UIColor.gray
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 100)
        tempLabel.textColor = UIColor.white
        
        contentView.addSubview(tempLabel)
        
        weatherIcon = UIImageView()
        //weatherIcon.backgroundColor = UIColor.green
        weatherIcon.contentMode = .scaleAspectFit
        weatherIcon.image = UIImage(named: "sunny")
        contentView.addSubview(weatherIcon)
        
        cityLabel = UILabel()
        cityLabel.text = "unknown city"
        cityLabel.textColor = UIColor.white
        //cityLabel.backgroundColor = UIColor.purple
        cityLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 30)
        contentView.addSubview(cityLabel)
        
    }
    
    private func addConstrains(){
        background.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
        controllerSwitch.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.right.equalTo(-20)
            make.height.width.equalTo(50)
        }
        
        CtoF.snp.makeConstraints { (make) in
            make.centerY.equalTo(controllerSwitch.snp.centerY)
            make.left.equalTo(25)
 
        }
        
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(UIScreen.main.bounds.size.height/3-40)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-40)
        }
        
        tempLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(UIScreen.main.bounds.size.height*(2/3)/3)
            
        }
        
        weatherIcon.snp.makeConstraints { (make) in
            make.top.equalTo(tempLabel.snp.bottom)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(UIScreen.main.bounds.size.height*(2/3)*(2/3)-70)
            
        }
        
        cityLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(weatherIcon.snp.bottom)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(0)

            
        }
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
