//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralTypeView: View {
    var funeralTypes = [FuneralType.burial, FuneralType.crematization]
    @State private var valid = false
    @State private var selectedFuneral = FuneralType.none
    @State private var showNote = false
    @ObservedObject var vm: FeneralViewModel
    //FuneralNote -> NoteWithAttachementView
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $vm.funeral.burial_type_note.bound, oldAttachedFiles: $vm.funeral.burial_type_note_attachments, noteAttachmentIds: $vm.funeral.burial_type_note_attachment)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
            }
            WishesFlowBaseView(stepNumber: 1.0, totalSteps: 12.0, noteText: $vm.funeral.burial_type_note.bound, note: true, showNote: $showNote, menuTitle: "Choix funéraires", title: "Quel rite souhaitez-vous ?", valid: .constant(vm.funeral.burial_type != 0), destination: AnyView(FuneralPlaceView(vm: vm)), viewModel: vm) {
                HStack {
                    ForEach(funeralTypes, id: \.self) { type in
                        ChoiceCard(text: type == .burial ? "Inhumation" : "Crémation", selected: .constant(vm.funeral.burial_type == type.rawValue))
                            .onTapGesture {
                                if  vm.funeral.burial_type == type.rawValue {
                                    vm.funeral.burial_type = 0
                                }
                                else {
                                vm.funeral.burial_type = type.rawValue
                                }
                            }
                    }
                }
            }
        }
    }
}
