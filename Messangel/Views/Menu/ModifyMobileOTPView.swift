//
//  KeyAccRegSMSView.swift
//  Messangel
//
//  Created by Saad on 12/13/21.
//

import SwiftUI
import NavigationStack

struct ModifyMobileOTPView: View {
    @EnvironmentObject private var auth: Auth
    @EnvironmentObject private var navModel: NavigationModel
    @State private var apiResponse = APIService.APIResponse(message: "")
    @State private var apiError = APIService.APIErr(error: "", error_description: "")
    @State var code = ""
    @State var loading = false
    @State private var succesAlert = false
    @State private var failureAlert = false
    @Binding var new_mobile: String
    @ObservedObject var vm:SecureAccessViewModel
    
    fileprivate func validateOTP() {
        vm.otp.otp = Int(code) ?? 0
        vm.authOTP {
            if vm.apiResponse.message == "1" {
                APIService.shared.post(model: Mobile(email: auth.user.email, new_number: new_mobile.replacingOccurrences(of: " ", with: "")), response: apiResponse, endpoint: "users/\(getUserId())/change-number", method: "PUT") { result in
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            loading.toggle()
                            self.apiResponse = response
                            if response.message.contains("confirmation link sent to") {
//                                auth.user.phone_number = new_mobile
//                                auth.updateUser()
                                succesAlert.toggle()
                            }
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            print(error.error_description)
                            self.apiError = error
                            failureAlert.toggle()
                        }
                    }
                }
            } else {
                loading.toggle()
            }
        }
    }
    
    var body: some View {
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
                    Text("")
                        .hidden()
                    Text("Inscrivez le code re??u par SMS")
                        .padding(.bottom)
                }
                .font(.system(size: 17), weight: .bold)
                .foregroundColor(.white)
                OTPTextFieldView(code: $code)
                    .disabled(loading)
                    .onChange(of: code) { value in
                        if value.count == 4 {
                            loading.toggle()
                            validateOTP()
                        }
                    }
                if loading {
                    Loader(tintColor: .white)
                }
                Spacer()
            }
            .padding()
        }
        .foregroundColor(.white)
        .alert("Confirmez votre demande", isPresented: $succesAlert, actions: {
            Button("OK", role: .cancel) {
                navModel.popContent(TabBarView.id)
            }
        }, message: {
            Text("Confirmez votre demande de modification par mail.")
        })
        .alert(isPresented: $failureAlert, content: {
            Alert(title: Text(apiError.error), message: Text(apiError.error_description))
        })
        .onDidAppear {
            if code.isEmpty {
                APIService.shared.post(model: OTP(phone_number: auth.user.phone_number), response: apiResponse, endpoint: "users/otp", token: false) { result in
                    switch result {
                    case .success(let res):
                        DispatchQueue.main.async {
                            self.apiResponse = res
                        }
                    case .failure(let err):
                        print(err)
                    }
                }
            }
        }
    }
}


