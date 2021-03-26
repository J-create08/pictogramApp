//
//  SignUpView.swift
//  PictogramApp
//
//  Created by Juan Carlos  Rojas on 25/3/21.
//

import SwiftUI

struct SignUpView: View {
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var username : String = ""
    
    var body: some View {
        ScrollView{
            VStack(spacing:20){
                VStack(alignment: .center) {
                    Image(systemName: "camera").font(.system(size: 60, weight: .black, design: .monospaced))
                        .foregroundColor(.orange)
                    Text("Welcome to Pictogram").font(.system(size :28, weight: .heavy))
                    Text("Sign Up").font(.system(size :16, weight: .medium))
                }
                VStack{
                    Group{
                        
                    }
                    FormField(value: $username, icon: "person.fill", placeholder: "Username")
                    FormField(value: $email, icon: "lock.fill", placeholder: "Email")
                    FormField(value: $password, icon: "lock.fill", placeholder: "Password", isSecure: true)
                    
                    Button(action: {}){
                        Text("Sign Up").font(.title)
                            .modifier(ButtonModifiers())
                            .padding()
                    }
                   
                    
                    
                }
            }
        }
        
       
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
