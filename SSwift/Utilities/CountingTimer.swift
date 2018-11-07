//
//  CountingTimer.swift
//  FinstroPay
//
//  Created by sondang on 6/8/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

class RepeatTask: NSObject {
    
    var timer: Timer!
    var timeInterval = 1
    var counting: ((_ countingNumber: Int) -> Void)?
    var complete: (() -> Void)?
    
    // repeat infinite
    init(withDelay timeInterval: Int?, completeblock: (() -> Void)?) {
        super.init()
        
        if completeblock != nil {
            self.complete = completeblock!
        }
        
        if timeInterval != nil {
            self.timeInterval = timeInterval!
        }
    }
    
    @objc func repeatComplete() {
        if complete != nil {
            complete!()
        }
    }
    
    func start() {
        stop()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.timeInterval), target: self, selector: #selector(repeatComplete), userInfo: nil, repeats: true)
    }
    
    func stop() {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
    func suppend() {
        if timer != nil {
            timer!.invalidate()
        }
    }
    
}

class CountingTask: RepeatTask {
    
    var countdownSecond = 0
    
    init(countDown second: Int, countingBlock: ((_ countingNumber: Int) -> Void)?, completeblock: (() -> Void)?) {
        super.init(withDelay: 1, completeblock: completeblock)
        
        countdownSecond = second
        if countingBlock != nil {
            self.counting = countingBlock!
        }
    }
    
    @objc override func repeatComplete() {
        countdownSecond -= 1
        if countdownSecond < 0 {
            if complete != nil {
                complete!()
            }
            
            stop()
        }
        else {
            if counting != nil {
                counting!(countdownSecond)
            }
        }
    }
    
}
