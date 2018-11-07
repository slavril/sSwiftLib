//
//  Logging.swift

//
//  Created by sondang on 9/19/18.
//  Copyright © 2018 sondang. All rights reserved.
//

import UIKit

private var logable = true

func logRequest(_ log: String?) {
    logPrint("=============")
    logPrint(log)
    logPrint("=============")
}

func logRequest(Url url: URL, method: String = "GET", body: String? = nil, headers: [String: String]) {
    logPrint(" ")
    logPrint(" -----API Request-------------------------------------------------")
    logPrint("|URL    : " + url.absoluteString)
    logPrint("|Method : " + method)
    if let _body = body {
        logPrint("|Body   : " + _body)
    }
    
    logPrint("|Headers:")
    for item in headers {
        logPrint("| \(item.key): \(item.value)")
    }
    
    logPrint(" -----End Request--------------------------------------------------")
    logPrint(" ")
}

func logResponse(Url url: URL, rawResponse raw: String) {
    logPrint(" ")
    logPrint(" -----API Response--------------------------------------------------")
    logPrint("|URL     : " + url.absoluteString)
    
    logPrint("|Response:\n " + raw)
    logPrint(" -----End Response--------------------------------------------------")
    logPrint(" ")
}

func logPrint(_ log: String?) {
    if let _log: String = log {
        print(_log)
    }
}

func logAPNSNotification(notification: SNotificationObject) {
    logPrint(" ")
    logPrint(" ----- APNS Notification-----------------------------------------------")
    logPrint("|MessageID: " + notification.messageId)
    if let string = notification.payloadString {
        logPrint("|Pay load : " + string)
    }
    
    logPrint(" -----End Notification-------------------------------------------------")
    logPrint(" ")
}
