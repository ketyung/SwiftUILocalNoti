//
//  NotificationHandler.swift
//  SwiftUILocalNoti
//
//  Created by Chee Ket Yung on 07/03/2021.
//

import Foundation
import UserNotifications


class NotificationHandler : NSObject, UNUserNotificationCenterDelegate {
    
    
    static let shared = NotificationHandler()
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
       
        let notiName = Notification.Name(response.notification.request.identifier)
        
        NotificationCenter.default.post(name:notiName , object: response.notification.request.content)
        
        completionHandler()
    }
    
  
    
    /** Handle notification when the app is in foreground */
    func userNotificationCenter(_ center: UNUserNotificationCenter,
             willPresent notification: UNNotification,
             withCompletionHandler completionHandler:
                @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let notiName = Notification.Name( notification.request.identifier )
        
        
        NotificationCenter.default.post(name:notiName , object: notification.request.content)
        
        completionHandler(.sound)
  
    }
   
    
}

extension NotificationHandler  {
    
    func requestPermission(_ delegate : UNUserNotificationCenterDelegate? = nil , onDeny handler : (()-> Void)? = nil){
        
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings(completionHandler: { settings in
        
            if settings.authorizationStatus == .denied {
                
                if let handler = handler {
                    
                    handler()
                }
                
                return
            }
            
            if settings.authorizationStatus != .authorized  {
            
                center.requestAuthorization(options: [.alert, .sound, .badge]) { _ , error in
                    
                    if let error = error {
                        print("error handling \(error)")
                    }
                    
                }
                
            }
            
        })
        
        center.delegate = delegate ?? self
    }
    
    
    func addNotification(id : String, title : String, subtitle : String , sound : UNNotificationSound = UNNotificationSound.default, trigger : UNNotificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)) {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        
        content.sound = sound

        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
    
    
    func removeAllNotifications(){
        
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    
    func removeNotifications(_ ids : [String]){
        
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ids)
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ids)
        
    }
}
