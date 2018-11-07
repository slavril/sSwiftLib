//
//  Created by sondang on 8/30/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

class App_UIApplication: UIApplication {
    
    /*
    private var counting: CountingTask?
    
    func reScheduleWithSecond(second: Int) {
        resetIdleTimer(second: second)
    }
    
    // resent the timer because there was user interaction
    private func resetIdleTimer(second: Int? = nil) {
        if let _counting = counting {
            _counting.stop()
        }
        
        var timeInSecond = Constant.timeoutInSeconds
        if second != nil {
            timeInSecond = second!
        }
        
        counting = CountingTask.init(countDown: timeInSecond, countingBlock: nil, completeblock: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.timeHasExceeded()
        })
        
        AuthenService.shared.registerTimeOutCheck()
        counting!.start()
    }
    
    // if the timer reaches the limit as defined in timeoutInSeconds, post this notification
    @objc private func timeHasExceeded() {
        AccountService.shared.forceLogout()
    }
    
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        
        if counting != nil {
            self.resetIdleTimer()
        }
        
        if let touches = event.allTouches {
            for touch in touches where touch.phase == UITouchPhase.began {
                self.resetIdleTimer()
            }
        }
    }
 */
    
}
