//
//  ViewController.swift
//  HandsOnSensor
//
//  Created by Randy Noel on 08/07/19.
//  Copyright © 2019 whiteHat. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    let motion = CMMotionManager()
    var timer:Timer? = Timer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        switchGyro.isOn = false
        switchAccel.isOn = false
        switchMagnet.isOn = false
        //deviceMotion()
    }
    
    //Gyrometer
    @IBOutlet weak var switchGyro: UISwitch!
    @IBAction func switchGyroAction(_ sender: Any) {
        if switchGyro.isOn == true{
            startGyro()
        }else{
            motion.stopGyroUpdates()
        }
    }
    
    @IBOutlet weak var lblGyro: UILabel!
    func startGyro(){
        if motion.isGyroAvailable {
            motion.gyroUpdateInterval = 1.0/3.0
            
            motion.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
                if let gyroData = data{
                    //print(gyroData)
                    if gyroData.rotationRate.x >= 1{
                        self.lblGyro.text = "Up"
                    }else if gyroData.rotationRate.x <= -1{
                        self.lblGyro.text = "Down"
                    }else if gyroData.rotationRate.y >= 1 {
                        self.lblGyro.text = "Right"
                    }else if gyroData.rotationRate.y <= -1{
                        self.lblGyro.text = "Left"
                    }
                }
            }
            
            
            //By timer
            //motion.startGyroUpdates()
//            timer = Timer(timeInterval: 1.0/3.0, repeats: true, block: { (timer) in
//                if let data = self.motion.gyroData{
//                    let x = data.rotationRate.x
//                    let y = data.rotationRate.y
//                    let z = data.rotationRate.z
//                    print("Gyro  x: ",x ," y: ", y ," z: ", z)
//                }
//            })
//
//            RunLoop.current.add(timer!, forMode: .default)
        }
    }
    
    
    //Accelerometer
    @IBOutlet weak var lblAccel: UILabel!
    @IBOutlet weak var switchAccel: UISwitch!
    @IBAction func switchAccelAction(_ sender: Any) {
        if switchAccel.isOn == true{
            startAccel()
        }else {
            motion.stopAccelerometerUpdates()
        }
        
    }
    
    func startAccel(){
        if motion.isAccelerometerAvailable{
            motion.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                if let accelData = data{
                    if accelData.acceleration.y > 0.8{
                        self.lblAccel.backgroundColor = .red
                    }else if accelData.acceleration.y > 0.5{
                        self.lblAccel.backgroundColor = .yellow
                    }else if accelData.acceleration.y > 0.3{
                        self.lblAccel.backgroundColor = .green
                    }
                }
            }
        }
    }
    
    
    //Magneto
    @IBOutlet weak var lblMagnet: UILabel!
    @IBOutlet weak var switchMagnet: UISwitch!
    @IBAction func switchMagnetaction(_ sender: Any) {
        if switchMagnet.isOn == true {
            startMagnet()
        }else{
            motion.stopMagnetometerUpdates()
        }
        
    }
    
    func startMagnet(){
        if motion.isMagnetometerAvailable{
            motion.startMagnetometerUpdates(to: OperationQueue.current!) { (data, error) in
                if let magnetData = data {
                    //print(magnetData)
                }
            }
        }
    }
    
//    let cm = CMMotionActivityManager()
//    func deviceMotion(){
//        cm.startActivityUpdates(to: OperationQueue.current!) { (data) in
//            if let datas = data {
//                print(datas)
//            }
//        }
//    }
    

}

