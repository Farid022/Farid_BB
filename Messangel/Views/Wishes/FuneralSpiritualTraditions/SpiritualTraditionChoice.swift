//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct SpiritualTraditionChoice: View {
    var funeralTypes = [SpiritualType.non_religious, SpiritualType.religious]
    @State private var showNote = false
    @ObservedObject var vm: FuneralSpritualityViewModel
    
    var body: some View {
        ZStack {
            if showNote {
                NoteWithAttachementView(showNote: $showNote, note: $vm.sprituality.spritual_ceremony_note.bound, oldAttachedFiles: $vm.sprituality.spritual_ceremony_note_attachments, noteAttachmentIds: $vm.sprituality.spritual_ceremony_note_attachment)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
            }
            FlowBaseView(stepNumber: 1.0, totalSteps: 2.0, noteText: $vm.sprituality.spritual_ceremony_note.bound, note: true, showNote: $showNote, menuTitle: "Spiritualité et traditions", title: "Quel type de cérémonie souhaitez-vous ?", valid: .constant(vm.sprituality.spritual_ceremony != SpiritualType.none.rawValue), destination: AnyView(FuneralBurialPlace(vm: vm))) {
                HStack {
                    ForEach(funeralTypes, id: \.self) { type in
                     
                        ChoiceCard(text: type == .non_religious ? "Non-religieuse" : "Religieuse ou philosophique", selected: .constant(vm.sprituality.spritual_ceremony == type.rawValue))
                            .onTapGesture {
                                if vm.sprituality.spritual_ceremony == type.rawValue
                                {
                                    vm.sprituality.spritual_ceremony = -1
                                }
                                else
                                {
                                    vm.sprituality.spritual_ceremony = type.rawValue
                                }
                               
                            }
                    }
                }
            }
        }
    }
}
