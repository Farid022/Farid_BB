//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralPlaceSelection: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var valid = false
    @State private var showNote = false
    @ObservedObject var vm: FuneralLocationViewModel
    private let title = "Indiquez le lieu de cérémonie"
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $vm.location.bury_location_note.bound, oldAttachedFiles: $vm.location.bury_location_note_attachments, noteAttachmentIds: $vm.location.bury_location_note_attachment)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
            }
            FlowBaseView(stepNumber: 2.0, totalSteps: 6.0, noteText: $vm.location.bury_location_note.bound, note: true, showNote: $showNote, menuTitle: "Lieux", title: title, valid: .constant(!vm.orgName.isEmpty), destination: AnyView(FuneralRestingPlace(vm: vm))) {
                if vm.orgName.isEmpty {
                    OrgListButton() {
                        navigationModel.presentContent(title) {
                            SingleOrgSelectionList(orgId: $vm.location.bury_location.toUnwrapped(defaultValue: 0), orgName: $vm.orgName, orgType: 9)
                        }
                    }
                } else {
                    HStack {
                        FuneralCapsuleView(name: vm.orgName) {
                            vm.location.bury_location = nil
                            vm.orgName = ""
                        }
                        Spacer()
                    }
                }
            }
            
        }
    }
}
