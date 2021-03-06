//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX
import SwiftUI

struct ObjectsDonationCount: View {
    private var donationTypes = [ClothsDonationType.single, ClothsDonationType.multiple]
    @State private var valid = false
    @State private var selectedDonation = ClothsDonationType.none
    @State private var showNote = false
    @State private var note = ""
    @StateObject private var vm = ObjectDonationViewModel()
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "Objets", title: "Souhaitez-vous ajouter un ou plusieurs objets ?", valid: $valid, destination: AnyView(ObjectsDonationName(vm: vm))) {
                HStack {
                    ForEach(donationTypes, id: \.self) { type in
                        ChoiceCard(text: type == .single ? "Un seul objet" : "Plusieurs objets", selected: .constant(selectedDonation == type))
                            .onTapGesture {
                                selectedDonation = type
                                vm.objectDonation.single_object = type == .single
                            }
                    }
                }
            }
            .onChange(of: selectedDonation) { value in
                valid = selectedDonation != .none
            }
        }
    }
}
