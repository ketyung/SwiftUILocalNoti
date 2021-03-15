//
//  MessageDataStore.swift
//  SwiftUILocalNoti
//
//  Created by Chee Ket Yung on 15/03/2021.
//

import Foundation

typealias DS  = ReminderMessageDataStore

struct ReminderMessageDataStore {
    
    static let shared = ReminderMessageDataStore()

    private let key = "com.techchee.savedReminderMessage"
   
    
    func save(_ message : ReminderMessage ){
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(message) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }
    
    
    func load() -> ReminderMessage{
        
        let defaults = UserDefaults.standard
        
        if let savedMessage = defaults.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let loadedMessage = try? decoder.decode(ReminderMessage.self, from: savedMessage) {
                
                return loadedMessage
            }
        }
        
        return ReminderMessage()
    }
}

