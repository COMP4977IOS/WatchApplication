//
//  ViewController.swift
//  Pedometer
//
//  Created by Johnny Marin on 2016-03-04.
//  Copyright © 2016 Johnny Marin. All rights reserved.
//

import UIKit
import CoreMotion



class ViewController: UIViewController {
   
    @IBOutlet weak var steps: UILabel!
    
    var days:[String] = []
    var stepsTaken:[Int] = []
    var stepCount = "n/a"

    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let cal = NSCalendar.currentCalendar()
        let comps = cal.components([.Hour, .Minute, .Second, .Nanosecond], fromDate: NSDate())
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        let timeZone = NSTimeZone.systemTimeZone()
        cal.timeZone = timeZone
        
                let midnightOfToday = cal.dateFromComponents(comps)!
        
        print(comps)
        
        
        if(CMPedometer.isStepCountingAvailable()){
            
            self.pedoMeter.startPedometerUpdatesFromDate(midnightOfToday) { // by replacing NSDate() with it
                (data: CMPedometerData?, error) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    print("steps: \(data!.numberOfSteps)")
                    
                    if(error == nil){
                        print("steps: \(data!.numberOfSteps)")
                        self.steps.text = "\(data!.numberOfSteps)"
                        Variables.stepsCounted = self.steps.text!
                    }
                })
            }
        }else {
            print("stepcounting unavailable")
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func refresh() {
        stepCount = Variables.stepsCounted
    }
    
  
    
}


