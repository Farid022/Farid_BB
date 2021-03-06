//
//  ModifyPasswordView.swift
//  Messangel
//
//  Created by Saad on 7/19/21.
//
import SwiftUI
import Peppermint
import NavigationStack

struct ModifyEmailView: View {
    @EnvironmentObject var auth: Auth
    @EnvironmentObject private var navModel: NavigationModel
    @State private var new_email = ""
    @State private var apiResponse = APIService.APIResponse(message: "")
    @State private var apiError = APIService.APIErr(error: "", error_description: "")
    @State private var valid = false
    @State private var editing = false
    @State private var alert = false
    let predicate = EmailPredicate()
    
    var body: some View {
        NavigationStackView(String(describing: Self.self)) {
        MenuBaseView(title: "Modifier adresse mail") {
            if !editing {
                AccessSecurityHeader()
            }
            HStack {
                VStack(spacing: 20) {
                    Text("Adresse mail actuelle")
                        .font(.system(size: 17), weight: .bold)
                    Text(auth.user.email)
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(.bottom)
            HStack {
                Text("Nouvelle adresse mail")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                Spacer()
            }
            TextField("Adresse mail", text: $new_email) { isEditing in
                self.editing = isEditing
            }
            .textFieldStyle(MyTextFieldStyle())
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .normalShadow()
            .padding(.bottom, 30)
            
            Button(action: {
                if new_email.isEmpty {
                    self.apiError = APIService.APIErr(error: "Veuillez remplir tous les champs", error_description: "Tous les champs sont obligatoires pour modifier votre adresse mail")
                    alert.toggle()
                }
                else if !predicate.evaluate(with: new_email) {
                    self.apiError = APIService.APIErr(error: "Nouvelle adresse : format incorrect", error_description: "Le format de votre nouvelle adresse mail est incorrect.")
                    alert.toggle()
                }
                else if new_email == auth.user.email {
                    self.apiError = APIService.APIErr(error: "Nouvelle adresse mail identique", error_description: "Votre nouvelle adresse mail doit ??tre diff??rente de votre adresse mail actuelle.")
                    alert.toggle()
                }
                if !valid {
                    return
                }
                navModel.pushContent(TabBarView.id) {
                    ModifyEmailSecView(new_email: $new_email)
                }
            }, label: {
                Text("Enregister")
            })
            .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .accentColor))
            Text("Une demande de confirmation vous sera envoy??e sur votre adresse mail actuelle.")
                .multilineTextAlignment(.center)
                .font(.system(size: 13))
                .padding(.top, 30)
        }
        }
        .onChange(of: new_email) { value in
            self.validate()
        }
        .alert(isPresented: $alert, content: {
            Alert(title: Text(apiResponse.message.isEmpty ? apiError.error : "Confirmez votre demande"), message: Text(apiResponse.message.isEmpty ? apiError.error_description : "Cliquez sur le lien que nous vous avons envoy?? par mail pour confirmer votre changement d???adresse mail."))
        })
    }
    
    private func validate() {
        self.valid = new_email != auth.user.email && predicate.evaluate(with: new_email)
    }
}
