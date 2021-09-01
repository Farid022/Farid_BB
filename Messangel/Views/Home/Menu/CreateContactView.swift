//
//  AddContactView.swift
//  Messangel
//
//  Created by Saad on 5/25/21.
//

import SwiftUI
import NavigationStack

struct CreateContactView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject private var auth: Auth
    @ObservedObject var vm: ContactViewModel
    @State private var minorAge = false
    @State private var isValid = false
    @State private var alert = false
    
    @State private var dob_day = 1
    @State private var dob_month = "AVRIL"
    @State private var dob_year = 2001
    
    var body: some View {
        MenuBaseView(title: "Créer un contact") {
            HStack {
                Text("Coordonnées du contact")
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.bottom, 20)
            Group {
                TextField("Prénom", text: $vm.contact.last_name)
                TextField("Nom", text: $vm.contact.first_name)
                TextField("Adresse mail", text: $vm.contact.email)
                    .keyboardType(.emailAddress)
                TextField("Numéro de téléphone mobile", text: $vm.contact.phone_number)
                    .keyboardType(.phonePad)
            }
            .textFieldStyle(MyTextFieldStyle())
            .shadow(color: .gray.opacity(0.2), radius: 10)
            .padding(.bottom)
            Spacer().frame(height: 20)
            HStack {
                VStack {
                    Group {
                        Toggle("Cette personne est majeure", isOn: $vm.contact.legal_age)
                            .onChange(of: vm.contact.legal_age) { value in
                                isValid = vm.contact.legal_age
                            }
                        Toggle("Cette personne est mineure", isOn: $minorAge)
                            .onChange(of: minorAge) { value in
                                isValid = minorAge
                            }
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .padding(.bottom, 30)
                }
                Spacer()
            }
            if minorAge {
                Text("Si cette personne est encore mineure au moment de votre décès, vos messages seront envoyés à vos Anges-gardiens.")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 13))
                    .padding(.bottom)
                HStack {
                    Text("Date de naissance du destinataire")
                    Spacer()
                }
                MyDatePickerView(day: $dob_day, month: $dob_month, year: $dob_year)
                    .shadow(color: .gray.opacity(0.2), radius: 10)
                    .padding(.bottom, 20)
            }
            Button(action: {
                if isValid {
                    vm.contact.user = auth.user.id ?? 0
                    vm.contact.dob = "\(dob_year)-\((months.firstIndex(of: dob_month) ?? 0) + 1)-\(dob_day)"
                    vm.createContact { success in
                        if success {
                            navigationModel.hideTopViewWithReverseAnimation()
                        } else {
                            alert.toggle()
                        }
                    }
                }
            }){
                HStack {
                    Image("ic_add-user")
                    Text("Créer")
                }
            }
            .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .accentColor))
        }
        .alert(isPresented: $alert, content: {
            Alert(title: Text(vm.apiError.error), message: Text(vm.apiError.error_description))
        })
    }
}

//struct AddContactView_Previews: PreviewProvider {
//    static var previews: some View {
//            CreateContactView()
//    }
//}
