//
//  StatsInterfaceController.swift
//  Arctic Run
//
//  Created by Johnny Marin on 2016-03-04.
//  Copyright © 2016 Johnny Marin. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity



class StatsInterfaceController: WKInterfaceController {
    @IBOutlet var stepsTaken: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if WCSession.defaultSession().reachable == true {
            
            let requestValues = ["command" : "refresh"]
            let session = WCSession.defaultSession()
            
            session.sendMessage(requestValues, replyHandler: { reply in
                self.stepsTaken.setText(reply["status"] as? String)
                }, errorHandler: { error in
                    print("error: \(error)")
            })
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
