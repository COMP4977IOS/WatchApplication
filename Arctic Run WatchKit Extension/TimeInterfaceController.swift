//
//  SecondInterfaceController.swift
//  Timer
//
//  Created by Johnny Marin on 2016-02-11.
//  Copyright © 2016 Johnny Marin. All rights reserved.
//

import WatchKit
import Foundation


class TimeInterfaceController: WKInterfaceController {
    
    let rest = "🚷"
    let runIcon = "🏃🏻"
    let walkIcon = "🚶🏽"
    var isWorkingOut = false
    var isRunning = true
    
    var intervalTimer = NSTimer()
    
    @IBOutlet var runTimer: WKInterfaceTimer!
    @IBOutlet var statusIconLabel: WKInterfaceLabel!
    @IBOutlet var statusTextLabel: WKInterfaceLabel!
    @IBOutlet var workoutIconLabel: WKInterfaceLabel!
    
    @IBAction func runWalkSwitch(value: Bool) {
        WKInterfaceDevice().playHaptic(.Notification)
        isRunning = value
        if value{
            workoutIconLabel.setText(icon())
            runWalkSwitch.setTitle("Run")
        }else {
            workoutIconLabel.setText(icon())
            runWalkSwitch.setTitle("Walk/Jog")
        }
        if isWorkingOut{
            timerReset()
        }
    }
    @IBOutlet var runWalkSwitch: WKInterfaceSwitch!
    
    @IBAction func didPressWorkoutButton() {
        isWorkingOut = !isWorkingOut
        
        if isWorkingOut{
            statusIconLabel.setText(icon())
            statusTextLabel.setText("Work Out!!!")
            workoutButton.setTitle("Rest")
            timerReset()
        }else {
            statusIconLabel.setText(rest)
            statusTextLabel.setText("Rest")
            workoutButton.setTitle("Work Out!!!")
            runTimer.stop()
            timerStop()
        }
    }
    
    @IBOutlet var workoutButton: WKInterfaceButton!
    
    func icon() -> String {
        if isRunning{
            return runIcon
        }else{
            return walkIcon
        }
    }
    
    func timerReset(){
        let interval:NSTimeInterval = 10.0
        runTimer.stop()
        let time = NSDate(timeIntervalSinceNow: interval)
        runTimer.setDate(time)
        runTimer.start()
        
        if intervalTimer.valid{intervalTimer.invalidate()} //shut off timer if on
        intervalTimer = NSTimer.scheduledTimerWithTimeInterval(10.0 ,
            target: self,
            selector: "timerDidEnd:",
            userInfo: nil,
            repeats: true)
    }
    
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        statusIconLabel.setText(rest)
        workoutIconLabel.setText(icon())
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func timerDidEnd (timer:NSTimer){
        isRunning = !isRunning
        runWalkSwitch.setOn(isRunning)
        runWalkSwitch(isRunning)
        timerReset()
    }
    
    func timerStop(){
        intervalTimer.invalidate()
    }
    
    
}
