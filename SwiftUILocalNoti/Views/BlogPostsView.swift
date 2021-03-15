//
//  MenuView.swift
//  SwiftUILocalNoti
//
//  Created by Chee Ket Yung on 11/03/2021.
//

import SwiftUI

struct BlogPostsView : View {
    
    var body: some View {
        
        NavigationView {
        
            List {
            
                NavigationLink(destination: WebView(urlString : "https://blog.techchee.com/handling-local-notification-in-swiftui")){
                    
                   Text("Blog post on Handling local notification in SwiftUI")
                }
            
                NavigationLink(destination: WebView(urlString : "https://blog.techchee.com/scheduling-local-notification-swiftui")){
                    
                   Text("Blog post on Scheduling local notification in SwiftUI - the MVVM way")
                }
            
            }
            .navigationTitle(Text("Blog Posts"))
            
        }
        
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    

}
