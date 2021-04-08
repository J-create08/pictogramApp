//
//  PostService.swift
//  PictogramApp
//
//  Created by Juan Carlos  Rojas on 7/4/21.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestore

class PostService {
    static var Posts = AuthService.storeRoot.collection("posts")
    static var AllPosts = AuthService.storeRoot.collection("allPosts")
    static var Timeline = AuthService.storeRoot.collection("timeline")
    
    static func postUserId(userId: String) -> DocumentReference {
        return Posts.document(userId)
    }
    
    static func timelineUserId(userId: String) -> DocumentReference {
        return Timeline.document(userId)
    }
    
    static func uploadPost(caption: String, imageData: Data, onSuccess: @escaping()-> Void, onError: @escaping(_ errorMessage: String)-> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let postId = PostService.postUserId(userId: userId).collection("posts").document().documentID
        
        let storagePostRef = StorageService.storagePostID(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.savePostPhoto(userId: userId, caption: caption, postId: postId, imageData: imageData, metaData: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
        
    }
}
