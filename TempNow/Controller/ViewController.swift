//
//  ViewController.swift
//  TempNow
//
//  Created by Chen Wang on 11/30/18.
//  Copyright © 2018 utopia incubator. All rights reserved.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    var background:UIImageView!
    var contentView:UIView!
    var controllerSwitch:UIButton!
    var tempLabel:UILabel!
    var weatherIcon:UIImageView!
    var CtoF:UISwitch!
    var cityLabel:UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addBackGroundImage()
        addButtons()
        addSwitch()
        createDisplayView()
        addConstrains()
        print()
    }
    
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
        print("controllerSwitchPressed")
        self.present(SearchController(), animated: true, completion: nil)
    }
    
    private func addSwitch(){
        CtoF = UISwitch()
        CtoF.addTarget(self, action: #selector(switchPressed(_:)), for: .valueChanged)
        self.view.addSubview(CtoF)
    }
    
    @objc private func switchPressed(_ sender:UISwitch){
        print(sender.isOn)
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
