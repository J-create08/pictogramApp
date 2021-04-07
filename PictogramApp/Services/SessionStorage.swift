//
//  SessionStorage.swift
//  PictogramApp
//
//  Created by Juan Carlos  Rojas on 6/4/21.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth

class SessionStorage: ObservableObject {
    var didChange = PassthroughSubject<SessionStorage, Never> ()
    
    @Published var session: User? {didSet{self.didChange.send(self)}}
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({
            (auth, user) in
            
            if let user = user {
                
                let firestoreUserId = AuthService.getUserId(userId: user.uid)
                firestoreUserId.getDocument {
                    (document, error) in
                    
                    if let dict = document?.data(){
                        guard let decodedUser = try? User.init(fromDictionary: dict) else {return}
                        self.session = decodedUser
                    }
                }
                
            } else {
                self.session = nil
            }
        })
    }
    
    func handleLogout() {
        do{
            try Auth.auth().signOut()
        } catch {
            
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}
