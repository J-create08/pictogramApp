//
//  AddView.swift
//  PictogramApp
//
//  Created by Juan Carlos  Rojas on 7/4/21.
//

import SwiftUI

struct PostView: View {
    @State private var postImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle:String = "Oh no 😩"
    @State private var text = ""
    
    func loadImage() {
        guard let inputImage = pickedImage else {return}
        postImage = inputImage
    }
    
    func uploadPost() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        self.clear()
        //connect upload
    }
    
    func clear() {
        self.text = ""
        self.imageData = Data()
        self.postImage = Image(systemName: "photo")
    }
    
    func errorCheck() -> String? {
        if text.trimmingCharacters(in: .whitespaces).isEmpty ||
            imageData.isEmpty {
            return "Please add a caption and remember to select an image for your post!"
        }
        return nil
    }
    
    var body: some View {
        
        VStack {
            
            Text("Create a post").font(.largeTitle).bold().foregroundColor(.gray)
                
            
            VStack {
                if postImage != nil {
                    postImage!.resizable()
                        .frame(width: 300, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(15)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 300, height: 220, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(.bottom)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                }
            }
            
            TextEditor(text: $text)
                .frame(height: 200)
                .padding(4)
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue))
                .padding(.horizontal)
            
            Button(action: uploadPost) {
                Text("Upload Post").font(.title).modifier(ButtonModifiers())
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
            }
            
        }.padding()
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
        }.actionSheet(isPresented: $showingActionSheet){
            ActionSheet(title: Text(""), buttons: [.default(Text("Choose A Photo")){
                self.sourceType = .photoLibrary
                self.showingImagePicker = true
            },
            .default(Text("Take A Photo")){
                self.sourceType = .camera
                self.showingImagePicker = true
            }, .cancel()
            ])
        }
        
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
