//
//  KeyAccRegEmailView.swift
//  Messangel
//
//  Created by Saad on 12/13/21.
//

import SwiftUI
import Peppermint

struct KeyAccRegEmailView: View {
    var keyAccCase: KeyAccCase
    @StateObject var vm = KeyAccViewModel()
    
    var body: some View {
        FlowBaseView(menuTitle: "Comptes-clés", title: "Indiquez une adresse email principale", valid: .constant(EmailPredicate().evaluate(with: vm.keyEmailAcc.email)), destination: AnyView(KeyAccRegPasswordView(keyAccCase: keyAccCase, vm: vm))) {
            TextField("prenom@mail.com", text: $vm.keyEmailAcc.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .normalShadow()
        }
    }
}
