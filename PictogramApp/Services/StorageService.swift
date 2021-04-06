//
//  StorageService.swift
//  PictogramApp
//
//  Created by Juan Carlos  Rojas on 4/4/21.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage


class StorageService {
    static var storage = Storage.storage()
    static var storageRoot = storage.reference(forURL: "gs://pictogram-64893.appspot.com")
    
    static var storageProfile = storageRoot.child("profile")
    
    static func storageProfileID(userId:String) -> StorageReference {
        return storageProfile.child(userId)
    }
    
    static func saveProfileImage(userId:String, username:String, email:String, imageData:Data, metaData:StorageMetadata, storageProfileImageRef:StorageReference, onSuccess: @escaping(_ user:User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        print("11111")
        storageProfileImageRef.putData(imageData, metadata: metaData) {
            (StorageMetadata, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            print("22222222")
            print(storageProfileImageRef)
            storageProfileImageRef.downloadURL {
                (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.displayName = username
                        changeRequest.commitChanges{
                            (error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                        }
                    }
                    
                    let firestoreUserId = AuthService.getUserId(userId: userId)
                    print(firestoreUserId)
                    print("FIRESTORE")
                    let user = User.init(uid: userId, email: email, profileImageUrl: metaImageUrl, username: username, searchName: username.splitString(), bio: "")
                    print(user)
                    print("USER")
                    guard let dict = try?user.asDictionary() else {return}
                    
                    firestoreUserId.setData(dict){
                        (error) in
                        if error != nil {
                            onError(error!.localizedDescription)
                        }
                    }
                    
                    onSuccess(user)
                    
                }
            }
        }
    }
}
