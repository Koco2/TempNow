//
//  SearchController.swift
//  TempNow
//
//  Created by Chen Wang on 11/30/18.
//  Copyright © 2018 utopia incubator. All rights reserved.
//

import UIKit

class SearchController: UIViewController {
    
    var background:UIImageView!
    var controllerSwitch:UIButton!
    var getWeatherButton:UIButton!
    var input:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        addBackGroundImage()
        addButtons()
        addTextField()
        addConstrains()

    }
    
    private func addBackGroundImage(){
        background = UIImageView(image: UIImage(named: "background2"))
        background.contentMode = UIView.ContentMode.scaleToFill
        self.view.addSubview(background)
    }
    
    private func addButtons(){
        controllerSwitch = UIButton()
        controllerSwitch.setBackgroundImage(UIImage(named: "switch"), for: .normal)
        controllerSwitch.addTarget(self, action: #selector(controllerSwitchPressed), for: .touchUpInside)
        self.view.addSubview(controllerSwitch)
        
        getWeatherButton = UIButton()
        getWeatherButton.setTitle("Get Weather", for: .normal)
        getWeatherButton.titleLabel?.font = .systemFont(ofSize: 20)
        getWeatherButton.addTarget(self, action: #selector(getWeatherButtonPressed), for: .touchUpInside)
        self.view.addSubview(getWeatherButton)
        
    }
    
    @objc private func controllerSwitchPressed(){
        self.dismiss(animated: true) {
            if(self.input.text! != ""){
                UserInput.sharedInstance = self.input.text!
            }else{
                print("empty input")
            }
        }
    }
    
    @objc private func getWeatherButtonPressed(){
        controllerSwitchPressed()
    }
    
    private func addTextField(){
        input = UITextField()
        input.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(input)
    }
    
    
    private func addConstrains(){
        background.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
        
        controllerSwitch.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.right.equalTo(-20)
            make.height.width.equalTo(50)
        }
        
        input.snp.makeConstraints { (make) in
            make.top.equalTo(UIScreen.main.bounds.size.height/4.5)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(UIScreen.main.bounds.size.width/1.8)
            make.height.equalTo(30)
        }
        
        getWeatherButton.snp.makeConstraints { (make) in
            make.top.equalTo(input.snp.bottom).offset(10)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(UIScreen.main.bounds.size.width/1.8)
            make.height.equalTo(30)
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
