//
//  LoginOrRegister.swift
//  PIA13iOSV4-1
//
//  Created by Mattias Arwidson on 2024-11-28.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct LoginOrRegister: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            Text("Login/Register")
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            
            Button(action: {
                Task{
                    await userLogin()
                }
            }) {
                Text("Login")
            }
            Button(action: {
                Task{
                    await userRegister()
                }
            }) {
                Text("Register")
            }
        }
        .padding()
    }
    func userLogin() async {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            print("Fel Login")
        }
    }
    func userRegister() async {
        do {
        let regResult = try await Auth.auth().createUser(withEmail: email, password: password)
        } catch {
            print("Fel Registrering")
        }
    }
}

#Preview {
    LoginOrRegister()
}
