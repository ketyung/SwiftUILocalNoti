//
//  SwiftUILocalNotiApp.swift
//  SwiftUILocalNoti
//
//  Created by Chee Ket Yung on 07/03/2021.
//

import SwiftUI

@main
struct SwiftUILocalNotiApp: App {
    
    @State var selectedTab = 2
    
    var body: some Scene {
        WindowGroup {
            
          // Example1()
           myTabView()
            
        }
    }
    
}

extension SwiftUILocalNotiApp {
    
    func myTabView() -> some View {
        
        TabView(selection: $selectedTab ){
           
            Example1()
            .tabItem {
                Label("Example 1", systemImage: "01.square")
            }
            .tag(0)
            
            Example2()
            .tabItem {
                Label("Example 1", systemImage: "02.square")
            }
            .tag(1)
                
            
            ReminderMessageView()
            .tabItem {
                Label("Reminder Message", systemImage: "deskclock")
            }
            .tag(2)
                
            
            BlogPostsView()
            .tabItem {
                Label("Blog Posts", systemImage: "info.circle")
            }
            .tag(3)
                
           
        }
    }
    
    
        

}
