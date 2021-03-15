//
//  ReminderMessageView.swift
//  SwiftUILocalNoti
//
//  Created by Chee Ket Yung on 10/03/2021.
//

import SwiftUI

struct ReminderMessageView : View {
    
    @ObservedObject private var viewModel = VM()
    
    @State private var toShowAlert : Bool = false
    
    @State private var toShowPopup : Bool = false
    
    @State private var notificationContent : UNNotificationContent?
   
    
    var body: some View {
        
        
        Form {
            
            TextField("Reminder :",text: $viewModel.text)
            
            HStack(spacing: 20) {
                DatePicker("",selection: $viewModel.date,
                    displayedComponents: [.hourAndMinute])
            
                Toggle("", isOn: $viewModel.addToNotification)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                
            }
            .frame(width: 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    
        }
       
        .onReceive (VM.notificationPublisher){ data in
        
            self.toShowPopup.toggle()
            
            if let content = (data.object as? UNNotificationContent){
                
                self.notificationContent = content
                
            }
            
        }
        
        .popup(isPresented: $toShowPopup, title: notificationContent?.title, subtitle: notificationContent?.subtitle)
       
        .onAppear{
            
            NotificationHandler.shared.requestPermission( onDeny: {
                
                self.toShowAlert.toggle()
                
            })
            
        }
       
        .alert(isPresented: $toShowAlert) {
            
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




extension ReminderMessageView {
    
    
    private func goToSettings(){
        
        DispatchQueue.main.async {
         
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
          
        }
       
    }
    
    
    
}





struct ReminderMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderMessageView()
    }
}
