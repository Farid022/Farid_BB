//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralContractLinkedOrgView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var showNote = false
    @ObservedObject var vm: FuneralOrgViewModel
    private let title = "Indiquez l’organisme qui gère votre contrat obsèques"
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $vm.funeralOrg.funeral_company_note.bound, oldAttachedFiles: $vm.funeralOrg.funeral_company_note_attachments, noteAttachmentIds: $vm.funeralOrg.funeral_company_note_attachment)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
            }
            FlowBaseView(stepNumber: 3.0, totalSteps: 4.0, noteText: $vm.funeralOrg.funeral_company_note.bound, note: true, showNote: $showNote, menuTitle: "Organismes spécialisés", title: title, valid: .constant(vm.funeralOrg.funeral_company != nil), destination: AnyView(FuneralContractNo(vm: vm))) {
                if vm.funeralOrg.funeral_company == nil {
                    OrgListButton() {
                        navigationModel.presentContent(title) {
                            SingleOrgSelectionList(orgId: $vm.funeralOrg.funeral_company.toUnwrapped(defaultValue: 0), orgName: $vm.orgName, orgType: 7)
                        }
                    }
                } else {
                    FuneralCapsuleView(name: vm.orgName) {
                        vm.funeralOrg.funeral_company = nil
                        vm.orgName.removeAll()
                    }
                }
            }
            
        }
    }
}
