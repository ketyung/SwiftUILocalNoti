//
//  ContentView.swift
//  SwiftUILocalNotifications
//
//  Created by Chee Ket Yung on 07/03/2021.
//

import SwiftUI


enum AlertType : Int {
    
    case message
    
    case go_to_settings
}

struct Example2 : View {
    
    
    @State private var toShowAlert : Bool = false
    
    @State private var alertType : AlertType = .message
    
    @State private var notificationContent : UNNotificationContent?
    
    static let testNotiId = "com.techchee.test.noti.id"
    
    
    var body: some View {
        
        
        let pub = NotificationCenter.default.publisher(for: Notification.Name(Example2.testNotiId))
        
        Button(action: {
       
            self.sendTestNotification()
            
        }, label: {
       
            Text("Tap me to send notification")
            .font(.headline)
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(10)
        })
    
        .onAppear{
            
            NotificationHandler.shared.requestPermission( onDeny: {
                
                self.alertType = .go_to_settings
                self.toShowAlert.toggle()
                
            })
            
        }
        
        .onReceive (pub, perform: { data in
        
            self.alertType = .message
            self.toShowAlert.toggle()
            
            if let content = (data.object as? UNNotificationContent){
                
                self.notificationContent = content
            }
        })
        
        .alert(isPresented: $toShowAlert) {
            
            alertBasedOnType(title: notificationContent?.title ?? "", message: notificationContent?.subtitle ?? "")
        }
         
    }
}

extension Example2 {
    
    
    private func goToSettings(){
        
        DispatchQueue.main.async {
         
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
          
        }
       
    }
    
    

    private func sendTestNotification(){
      
        NotificationHandler.shared.addNotification(id : Example2.testNotiId,
            title:"Hello World!" , subtitle: "Have a nice day!")
        
    }
    
}




extension Example2 {
    
    
    
    private func alertBasedOnType (title : String = "Notification Received", message: String = "Bye!") -> Alert {
        
        switch (alertType){
        
            case .message :
            
                return Alert(title: Text(title), message: Text(message), dismissButton: .default(Text("OK")))
   
            case .go_to_settings :
            
                return Alert(
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

