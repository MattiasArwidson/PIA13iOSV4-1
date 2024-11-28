//
//  ContentView.swift
//  PIA13iOSV4-1
//
//  Created by Mattias Arwidson on 2024-11-25.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @State var isLoggedIn: Bool?
    
    var body: some View {
        VStack{
            if isLoggedIn == true {
                Start()
            }
            if isLoggedIn == false{
                LoginOrRegister()
            }
        }
        .onAppear() {
            Auth.auth().addStateDidChangeListener { auth, user in
                print("User changed")
                
                if Auth.auth().currentUser == nil {
                    isLoggedIn = false
                } else {
                    isLoggedIn = true
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
