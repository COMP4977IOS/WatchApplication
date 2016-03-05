//
//  ThirdInterfaceController.swift
//  Timer
//
//  Created by Johnny Marin on 2016-02-11.
//  Copyright © 2016 Johnny Marin. All rights reserved.
//

import WatchKit
import Foundation


class AchievementsInterfaceController: WKInterfaceController {
    
    @IBOutlet var picker: WKInterfacePicker!
    var text = ""
    
    @IBAction func pickerSelectedItemChange(value: Int) {
        //print("List Picker: \(achievements[value].0) selected")
        text = achievements[value].2
    }
    
    @IBAction func showAlertPressed() {
        let cancel = WKAlertAction(title: "Cancel", style: WKAlertActionStyle.Cancel, handler: { () -> Void in
            
        })
        
        let action = WKAlertAction(title: "Action", style: WKAlertActionStyle.Default, handler: { () -> Void in
            
        })
        
        self.presentAlertControllerWithTitle("Alert", message: text, preferredStyle: WKAlertControllerStyle.SideBySideButtonsAlert, actions: [cancel, action])
    }
    
    var achievements: [(String, String, String)] = [
        ("Achievement 1", "Unlocked", "Unlocked on 2/2/2015"),
        ("Achievement 2", "Unlocked", "Unlocked on 3/3/2015"),
        ("Achievement 3", "Locked", "Locked - Walk 1000 KM"),
        ("Achievement 4", "Locked", "Locked - Learn to fly m8"),
        ("Achievement 5", "Locked", "Locked - ???"),
        ("Achievement 6", "Locked", "Locked - Uninstall this app") ]
    
    
    override func willActivate() {
        super.willActivate()
        
        let pickerItems: [WKPickerItem] = achievements.map {
            let pickerItem = WKPickerItem()
            pickerItem.title = $0.0
            pickerItem.caption = $0.1
            return pickerItem
        }
        
        picker.setItems(pickerItems)
        
        
    }
    
    
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        
    }
    
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
}
