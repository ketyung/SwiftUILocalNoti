//
//  Extensions.swift
//  SwiftUILocalNoti
//
//  Created by Chee Ket Yung on 14/03/2021.
//

import Foundation

extension Notification.Name {
    
    static let LuckyMessageAdded =
        Notification.Name ("com.techchee.luckymessage")
    
}


extension NotificationCenter.Publisher {
    
    
    static var luckyMessagePublisher : NotificationCenter.Publisher  {
        
        return NotificationCenter.default.publisher(for: Notification.Name(LuckyMessageViewModel.notificationId))
        
    }
   
}
