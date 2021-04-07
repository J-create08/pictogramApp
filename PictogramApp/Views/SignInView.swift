//
//  SignInView.swift
//  PictogramApp
//
//  Created by Juan Carlos  Rojas on 25/3/21.
//

import SwiftUI

struct SignInView: View {
    @State private var email : String = ""
    @State private var password : String = ""
    
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle:String = "Oh no!"
    
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty  {
            return "Please fill in all the fields."
        }
        return nil
    }
    
    func clear() {
        self.email = ""
        self.password = ""
    }
    
    func userSignIn() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.signIn(email: email, password: password, onSuccess: {(user) in self.clear()}) {
            (errorMessage) in
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }
    
        
    var body: some View {
        
        NavigationView {
            VStack(spacing: 20){
                Image(systemName: "camera").font(.system(size: 60, weight: .black, design: .monospaced))
                    .foregroundColor(.orange)
                VStack(alignment: .center) {
                    Text("Welcome Back!").font(.system(size :32, weight: .heavy))
                    Text("Sign In").font(.system(size :20, weight: .medium))
                    FormField(value: $email, icon: "envelope.fill", placeholder: "Email")
                    FormField(value: $password, icon: "lock.fill", placeholder: "Password", isSecure: true)
                    
                    Button(action: userSignIn){
                        Text("Sign In").font(.title)
                            .modifier(ButtonModifiers())
                            .padding()
                        
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                    }
                    
                    HStack {
                        Text("New?")
                        NavigationLink(destination: SignUpView()) {
                            Text("Create an account").font(.system(size:18, weight: .medium ))
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        }
                    }
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

