//
//  MyMessagesSec.swift
//  Messangel
//
//  Created by Saad on 6/17/22.
//

import SwiftUI
import NavigationStack

struct MyMessagesSec: View {
    @StateObject private var vm = SecureAccessViewModel()
    @EnvironmentObject private var navModel: NavigationModel
    @State private var hidePassword = true
    var body: some View {
        NavigationStackView(String(describing: Self.self)) {
            ZStack(alignment: .top) {
                Color.accentColor
                    .ignoresSafeArea()
                VStack(spacing: 7) {
                    HStack {
                        BackButton()
                        Spacer()
                    }
                    Spacer()
                    Image("ic_lock_white")
                    Group {
                        Text("Accès sécurisé")
                        Text("Entrez votre mot de passe Messangel")
                            .padding(.bottom)
                    }
                    .font(.system(size: 17), weight: .bold)
                    MyTextField(placeholder: "Mot de passe", text: $vm.password.password, isSecureTextEntry: $hidePassword)
                        .xTextFieldStyle()
                        .overlay(HStack {
                            Spacer()
                            Image(systemName: hidePassword ? "eye" : "eye.slash")
                                .foregroundColor(.black)
                                .padding(.trailing, 20)
                                .animation(.default, value: hidePassword)
                                .onTapGesture {
                                    hidePassword.toggle()
                                }
                        })
                    Spacer()
                        .frame(height: 100)
                    MyLink(text: "Politique de confidentialité", fontSize: 15)
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(isCustomAction: true, customAction: {
                            vm.authPassword {
                                if vm.apiResponse.message == "1" {
                                    navModel.pushContent(String(describing: Self.self)) {
                                        MyMessagesUsers()
                                    }
                                }
                            }
                        }, active: .constant(!vm.password.password.isEmpty))
                    }
                    Spacer()
                        .frame(height: 50)
                }
                .foregroundColor(.white)
                .padding()
            }
        }
    }
}
