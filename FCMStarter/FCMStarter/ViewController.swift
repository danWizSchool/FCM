//
//  ViewController.swift
//  FCMStarter
//
//  Created by wiz_Dan on 25/11/2019.
//  Copyright © 2019 wiz_Dan. All rights reserved.
//

// ipad d8QYsQeiO5Q:APA91bG4uCV67DaST3XRxUjyyfhSQl8al5FuY9thhOTBcqOSRZifSx3uYzXvkJNPIN2Rj_oCuk-bohbNsgf5Hg1Oy0QahC-pTSRttmFVdLuKdP8MtYa_dOEqkS_TLv-6lRZGxXljDP1D
// iphone ed3BnsS9zao:APA91bEYm-utkMkCi1K_gka3byPw4kx-lx0EzftQcocDs-HkQQ3yAdT18B4DOa-UfXuzrNsrlo9dtbo_MPmgIdu5fxdYGS_hZ9ZQYnEmHtp08aVSPrg4En8gKRR0NwApvGHsB-RsJ15c
// ipad_sik d9H7GI0THy8:APA91bF7QZOeuEm7tksl9oVvtsPZ3iQTPirb4ruh5sCfE6Wjd9UAIfTJWknBLNWXA6m-TKOBD-lTA5SO0KCRRuHVvJkPYnlPZqy4Vqz4ZP3JurfVu9o6_G3StB_VKf3AugY_7_eDn7hz

import UIKit
import Alamofire
import Firebase

class ViewController: UIViewController {
    
    let center = UNUserNotificationCenter.current()
    let notiSender = PushNotificationSender()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveMessageNoti(notification:)), name: .receive, object: nil)
    }
    
    @objc func receiveMessageNoti(notification: Notification) {
        if let userInfo = notification.userInfo, let notification = userInfo["notification"] as? UNNotification {
            let content = notification.request.content
            if let customData = content.userInfo["customData"] as? String {
                print("customData : \(customData)")
                let showMessage = "title : \(content.title)\nbody : \(content.body)\nsender's name is \(customData)"
                showAlert(showMessage)
            }
            
        }
    }
    
    
    @IBAction func tapAuth(_ sender: Any) {
        center.getNotificationSettings { (setting) in
            switch setting.authorizationStatus {
            case .denied:
                logger("auth is denied")
                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                DispatchQueue.main.async {
                    UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (_, _) in }
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
    
    @IBOutlet weak var pad: UIButton!
    @IBOutlet weak var mayPad: UIButton!
    @IBOutlet weak var myPhone: UIButton!
    @IBAction func tapSendMessage(_ sender: UIButton) {
        var tokenName = ""
        switch sender {
        case pad:
            tokenName = "d8QYsQeiO5Q:APA91bG4uCV67DaST3XRxUjyyfhSQl8al5FuY9thhOTBcqOSRZifSx3uYzXvkJNPIN2Rj_oCuk-bohbNsgf5Hg1Oy0QahC-pTSRttmFVdLuKdP8MtYa_dOEqkS_TLv-6lRZGxXljDP1D"
        case mayPad:
            tokenName = "d9H7GI0THy8:APA91bF7QZOeuEm7tksl9oVvtsPZ3iQTPirb4ruh5sCfE6Wjd9UAIfTJWknBLNWXA6m-TKOBD-lTA5SO0KCRRuHVvJkPYnlPZqy4Vqz4ZP3JurfVu9o6_G3StB_VKf3AugY_7_eDn7hz"
        case myPhone:
            tokenName = "ed3BnsS9zao:APA91bEYm-utkMkCi1K_gka3byPw4kx-lx0EzftQcocDs-HkQQ3yAdT18B4DOa-UfXuzrNsrlo9dtbo_MPmgIdu5fxdYGS_hZ9ZQYnEmHtp08aVSPrg4En8gKRR0NwApvGHsB-RsJ15c"
        default:
            break
        }
        notiSender.sendPushNotification(to: tokenName, title: "test title", body: "test body")
    }
    
    @IBAction func tapFCMToken(_ sender: Any) {
        logger(Messaging.messaging().fcmToken, "ss")
    }
    @IBAction func tapWizDefaultToken(_ sender: Any) {
        logger(WizDefault.shared.fcmToken)
    }
}

