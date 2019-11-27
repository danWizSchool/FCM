//
//  ViewController.swift
//  FCMStarter
//
//  Created by wiz_Dan on 25/11/2019.
//  Copyright © 2019 wiz_Dan. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class ViewController: UIViewController {
    
    let center = UNUserNotificationCenter.current()
    let notiSender = PushNotificationSender()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapAuth(_ sender: Any) {
        center.getNotificationSettings { (setting) in
            switch setting.authorizationStatus {
            case .denied:
                logger("auth is denied")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            case .authorized:
                logger("auth is authorized")
                break
            case .notDetermined:
                logger("auth is notDetermined")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            default:
                break
            }
            
            logger("alert setting :", setting.alertSetting.rawValue)
        }
    }
    @IBAction func tapSendMessage(_ sender: Any) {
        guard let fcmToken = WizDefault.shared.fcmToken else { return }
        notiSender.sendPushNotification(to: fcmToken, title: "test title", body: "test body")
    }
    
    @IBAction func tapFCMToken(_ sender: Any) {
        logger(Messaging.messaging().fcmToken, "ss")
    }
    @IBAction func tapWizDefaultToken(_ sender: Any) {
        logger(WizDefault.shared.fcmToken)
    }
}

