//
//  ReminderMessage.swift
//  SwiftUILocalNoti
//
//  Created by Chee Ket Yung on 10/03/2021.
//

import Foundation

struct ReminderMessage : Codable {
    
    var date : Date = Date()
    
    var addToNotfication : Bool = false 
    
    var text : String = "Take Your Breakfast"
    
}
