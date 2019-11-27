//
//  AppDelegate.swift
//  FCMStarter
//
//  Created by wiz_Dan on 25/11/2019.
//  Copyright © 2019 wiz_Dan. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let pushManager = PushNotificationManager(userID: "dan")
           pushManager.registerForPushNotifications()
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = pushManager
        
        logger("User Language for localizing :", NSLocale.preferredLanguages)
        
        return true
    }
    
    // [END receive_message]
    // APNs에서 device token 발급 실패
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
      logger("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // APNs에서 device token 발급 성공
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        logger("APNs token retrieved: \(deviceToken)")
      // With swizzling disabled you must set the APNs token here.
      // Messaging.messaging().apnsToken = deviceToken
    }
    
    

    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        logger("didReceiveRemoteNotification")
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification
      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)
      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        logger("Message ID: \(messageID)")
      }

      // Print full message.
      logger("user Info : ",userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        logger("didReceiveRemoteNotification , fetchCompletionHandler")
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification
      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)
      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        logger("Message ID: \(messageID)")
      }

      // Print full message.
      logger(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }

}
