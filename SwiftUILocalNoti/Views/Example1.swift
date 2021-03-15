//
//  Example1.swift
//  SwiftUILocalNoti
//
//  Created by Chee Ket Yung on 11/03/2021.
//

import SwiftUI

struct Example1 : View {
    
    @State private var toShowAlert : Bool = false
       
    var body: some View {
        
        let notiName = "com.techchee.test.notification"
        let pub = NotificationCenter.default.publisher(
                           for: Notification.Name(notiName))
        VStack {
            
            Button(action: {
                    NotificationHandler.shared.addNotification(
                       id : notiName,
                       title:"Your Notification" , subtitle: "Have a nice day!")
                }, label : {
                    Text("Send Notification")
            })
        }
        
        .onReceive(pub){ data in
             // execute other methods when the
             // Combine publisher with the specified
             // name received
             if let content = (data.object as? UNNotificationContent){
                 print("title:\(content.title), subtitle:\(content.subtitle)")
             }
        }
        
        .onAppear{
            NotificationHandler.shared.requestPermission( onDeny: {
            self.toShowAlert.toggle() })
            
        }
        
        .alert(isPresented: $toShowAlert){
            Alert(
               title: Text("Notification has been disabled for this app"),
               message: Text("Please go to settings to enable it now"),
               primaryButton: .default(Text("Go To Settings")) {
                   
                   self.goToSettings()
               },
               secondaryButton: .cancel()
            )
        }
        
        
    }
}

extension Example1 {
    
    
    private func goToSettings(){
        
        DispatchQueue.main.async {
         
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
          
        }
       
    }
}
