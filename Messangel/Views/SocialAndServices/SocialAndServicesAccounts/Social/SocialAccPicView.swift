//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX

struct SocialAccPicView: View {
    @State private var valid = false
    @State private var showNote = false
    @State private var note = ""
    @State private var inviteImage = UIImage()
    @State private var isShowPhotoLibrary = false
    @State private var cgImage = UIImage().cgImage
    @StateObject private var imageLoader = ImageLoader(urlString: "")
    @ObservedObject var vm: OnlineServiceViewModel
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "Ajouter un réseau social", title: "INSTAGRAM – Sélectionnez une photo pour accompagner ce message", valid: .constant(true), destination: AnyView(SocialPostTimeView(vm: vm))) {
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(width: 66, height: 66)
                    .cornerRadius(30)
                    .overlay(
                        Button(action: {
                            isShowPhotoLibrary.toggle()
                        }, label: {
                            ZStack {
                                    Image("ic_camera")
                                
                                Image(uiImage: inviteImage)
                                    .resizable()
                                    .frame(width: 66, height: 66)
                                    .clipShape(Circle())
                                    .onReceive(imageLoader.didChange) { data in
                                        self.inviteImage = UIImage(data: data) ?? UIImage()
                                        self.cgImage = self.inviteImage.cgImage
                                        Networking.shared.upload(inviteImage.jpegData(compressionQuality: 1)!, fileName: "msgl_user_\(getUserId())_invitation_photo.jpeg", fileType: "image") { result in
                                            switch result {
                                            case .success(let response):
                                                DispatchQueue.main.async {
                                                    self.vm.account.lastPostImage = response.files.first?.path ?? ""
                                                }
                                            case .failure(let error):
                                                print("Profile image upload failed: \(error)")
                                            }
                                        }
                                    }
                            }
                        })
                    )
                if inviteImage.cgImage == nil {
                    Text("Ajouter une photo")
                        .underline()
                }
            }
            
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(selectedImage: $inviteImage)
        }
    }
}
