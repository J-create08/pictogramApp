//
//  ContentView.swift
//  PictogramApp
//
//  Created by Juan Carlos  Rojas on 25/3/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var session: SessionStorage
    
    func sessionListener() {
        session.listen()
    }
    
    var body: some View {
        Group {
            if(session.session) != nil {
                HomeView()
            } else {
                SignInView()
            }
        }.onAppear(perform: sessionListener)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
