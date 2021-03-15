//
//  ReminderMessageViewModel.swift
//  SwiftUILocalNoti
//
//  Created by Chee Ket Yung on 10/03/2021.
//

import Foundation
import UserNotifications
import Combine

final class ReminderMessageViewModel : ObservableObject {

    @Published private var reminderMessage = DS.shared.load() {
        
        didSet {
            saveReminderMessage()
            manageMessageNotification()
        }
    }
    
    
    var date : Date {
        
        get {
            return reminderMessage.date
        }
        
        set(newDate){
            
            reminderMessage.date = newDate
            reminderMessage.addToNotfication = true
        }
    }
    
    var addToNotification : Bool {
        
        get {
            reminderMessage.addToNotfication
        }
        set (addToNotification){
  
            reminderMessage.addToNotfication = addToNotification
        }
    }
    
    var text : String {
        
        get {
            reminderMessage.text
        }
        
        set(newText){
            
            reminderMessage.text = newText
        }
    }
    
    
}

typealias VM = ReminderMessageViewModel

extension ReminderMessageViewModel {
    
    func saveReminderMessage(){
        
        DS.shared.save(reminderMessage)
    }
    
}

extension ReminderMessageViewModel {
    
    static let notificationId = "com.techchee.luckymessage"
    
   
    static func toHourAndMinute(date : Date) -> DateComponents {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date )
        
        return components
    }

    
    
    
    func manageMessageNotification(){
      
        // remove the notifications first
        NotificationHandler.shared.removeNotifications([VM.notificationId])
 
        if self.addToNotification {
      
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: VM.toHourAndMinute(date: self.date)  , repeats: true)
            
            NotificationHandler.shared.addNotification(id : VM.notificationId,
                                                       title:"A simple reminder!" ,
                                                       subtitle: reminderMessage.text, trigger : trigger)
        
        }
        
    }
    
}

extension ReminderMessageViewModel {
    
    static var notificationPublisher : NotificationCenter.Publisher  {
        
        NotificationCenter.default.publisher(for: Notification.Name(VM.notificationId))
    }
    
}
