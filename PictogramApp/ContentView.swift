//
//  ContentView.swift
//  PictogramApp
//
//  Created by Juan Carlos  Rojas on 25/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var mail = ""
    @State private var password = ""
    var body: some View {
        VStack{
            FormField(value: $mail, icon: "mail", placeholder: "Enter email")
            FormField(value: $password, icon: "lock", placeholder: "Enter password", isSecure: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
