//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct SocialAccPicView: View {
    @State private var valid = false
    @State private var showNote = false
    @State private var isShowImagePickerOptions = false
    @ObservedObject var vm: OnlineServiceViewModel
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $vm.account.lastPostImageNote.bound, oldAttachedFiles: $vm.account.lastPostImageNoteAttachments, noteAttachmentIds: $vm.account.lastPostImageNoteAttachment)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
            }
            FlowBaseView(stepNumber: 5.0, totalSteps: 5.0, noteText: $vm.account.lastPostImageNote.bound, note: true, showNote: $showNote, menuTitle: "Ajouter un réseau social", title: "INSTAGRAM – Sélectionnez une photo pour accompagner ce message", valid: .constant(true), destination: AnyView(SocialPostTimeView(vm: vm))) {
                ImageSelectionView(showImagePickerOptions: $isShowImagePickerOptions, localImage: $vm.socialAccPic, remoteImage: vm.account.lastPostImage ?? "", imageSize: 128.0)
            }
        }
    }
}
