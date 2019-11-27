//
//  PushNotificationSender.swift
//  FCMStarter
//
//  Created by wiz_Dan on 27/11/2019.
//  Copyright © 2019 wiz_Dan. All rights reserved.
//

import UIKit

// ipad d8QYsQeiO5Q:APA91bG4uCV67DaST3XRxUjyyfhSQl8al5FuY9thhOTBcqOSRZifSx3uYzXvkJNPIN2Rj_oCuk-bohbNsgf5Hg1Oy0QahC-pTSRttmFVdLuKdP8MtYa_dOEqkS_TLv-6lRZGxXljDP1D
// iphone ed3BnsS9zao:APA91bEYm-utkMkCi1K_gka3byPw4kx-lx0EzftQcocDs-HkQQ3yAdT18B4DOa-UfXuzrNsrlo9dtbo_MPmgIdu5fxdYGS_hZ9ZQYnEmHtp08aVSPrg4En8gKRR0NwApvGHsB-RsJ15c
// ipad_sik d9H7GI0THy8:APA91bF7QZOeuEm7tksl9oVvtsPZ3iQTPirb4ruh5sCfE6Wjd9UAIfTJWknBLNWXA6m-TKOBD-lTA5SO0KCRRuHVvJkPYnlPZqy4Vqz4ZP3JurfVu9o6_G3StB_VKf3AugY_7_eDn7hz

class PushNotificationSender {
    func sendPushNotification(to token: String, title: String, body: String) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : token,
                                           "notification" : ["title" : title, "body" : body],
                                           "bedge" : 1,
                                           "data" : ["customData" : UIDevice.current.name]
        ]
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAAfaDmZLQ:APA91bFeXt2DvBqXz2qBI_Z0hYfbSx9OVneEIu5Yqbj--HiIZzcpFUqALreYjFJOFlgxLfqv7d-9V6rlw2nOgwvrRfF0Vw6GFAsxin3mJ3PM6--06pOPtj18lloADGBMYmHWyBLQvIkG", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        logger("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}

