//
//  AccelerometerHandler.swift
//  STP_Dots
//
//  Created by Steven Pautler on 1/24/16.
//  Copyright © 2016 Steve. All rights reserved.
//

import Foundation
import CoreMotion

typealias AccelerationBlock = (CMAcceleration)->()

class AccelerometerHandler {
    let manager: CMMotionManager
    let updateInterval = 0.025
    let callback: AccelerationBlock
    
    init(_ cb: AccelerationBlock) {
        manager = CMMotionManager()
        manager.accelerometerUpdateInterval = updateInterval
        callback = cb
    }
    
    func start() {
        manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) { [weak self] (data, error) -> Void in
            if let _ = error {
                //handle error
            } else if let data = data {
                self?.callback(data.acceleration)
            } else {
                //no data and no error.  wtf!?
            }
        }
    }
    
    deinit {
        manager.stopAccelerometerUpdates()
    }
}
