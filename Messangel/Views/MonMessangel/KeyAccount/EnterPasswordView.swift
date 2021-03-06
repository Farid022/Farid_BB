//
//  EnterPasswordView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 3/21/22.
//

import SwiftUI
import NavigationStack


struct EnterPasswordView: View {
    @StateObject private var KeyAccountVerficationViewModel = keyAccountVerficationViewModel()
    
    @EnvironmentObject private var navigationModel: NavigationModel
    @State var code: String = ""
    @State var navigate: Bool = false
    @State private var valid = true
    @State private var hidePassword = true
    static let id = String(describing: Self.self)
    @State private var alert = false
    @State private var apiError = APIService.APIErr(error: "Password", error_description: "Enter the right Password")
    var isEmail: Bool
    var emailDetail: PrimaryEmailAcc
    var phoneDetail: PrimaryPhone
    var body: some View {
        NavigationStackView("EnterThePasswordView") {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack(spacing: 0.0) {
                Color.accentColor
                    .ignoresSafeArea()
                    .frame(height: 5)
                NavBar()
                    .overlay(HStack {
                        BackButton()
                        Spacer()
                        Text("")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()

                    }
                    .padding(.trailing)
                    .padding(.leading))
                
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                         Color.accentColor
                        .ignoresSafeArea()
                        
                    ScrollView {
                        Group
                        {
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                        Group
                        {
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                       HStack(alignment: .center)
                        {
                            
                            HStack(alignment:.center)
                            {
                            VStack(alignment: .center)
                            {
                                
                            Spacer()
                           
                            Image("ic_lock_white")
                                .frame(width: 21, height: 21)
                                .padding(.bottom,40)
                            Text("Acc??s s??curis??.")
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.leading,16)
                                .padding(.trailing,24)
                            Text("Entrez votre mot de passe Messangel ")
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.leading,16)
                                .padding(.trailing,24)
                            HStack(alignment: .center)
                            {
                                SecureField("Mot de passe", text: $code)
                                 
                                    .frame(height:60)
                                 
                                    .padding(.horizontal,18)
                            }
                            
                            Spacer()
                            Text("Politique de confidentialit??")
                                .font(.system(size: 15))
                                .fontWeight(.regular)
                                .multilineTextAlignment(.center)
                                .padding(.leading,16)
                                .padding(.trailing,24)
                                .foregroundColor(.white)
                                .padding(.top,100)
                            
                            Rectangle()
                                .frame(width: 200, height: 1, alignment: .center)
                                .padding(.top,-10)
                                .foregroundColor(.white)
                                
                                Spacer()
                               HStack
                                {
                                Spacer()
                                    
                                    
                                    VStack{
                                        Button(action: {
                                            
                                            
                                            APIService.shared.post(model: passwordItem(password: code), response: messageItem(), endpoint: "users/\(getUserId())/access") { result in
                                                switch result {
                                                case .success(let data):
                                                    DispatchQueue.main.async {
                                                        if data.message == "1"
                                                        {
                                                            navigationModel.pushContent("EnterThePasswordView") {
                                                        
                                                                EnterOTPView(isEmail: isEmail, emailDetail: emailDetail, phoneDetail: phoneDetail)
                                                            }
                                                        }
                                                        else
                                                        {
                                                            alert.toggle()
                                                        }
                                                    }
                                                case .failure(let error):
                                                    DispatchQueue.main.async {
                                                        print(error.error_description)
                                                        self.apiError = error
                                                       
                                                    }
                                                }
                                            }


                                            
                                        }) {
                                            Image("ic_nextArrow")
                                            .frame(width: 56, height: 56)
                                            .foregroundColor(Color.accentColor)
                                        }
                                        .frame(width: 56, height: 56)
                                        .foregroundColor(.white)
                                        .background(.white)
                                        .cornerRadius(23)
                                        .padding(.top,100)
                                        .padding(.trailing,24)
                                        
                                      
                                    
                            //NextButton(source: EnterPasswordView.id, destination: AnyView(EnterOTPView()), active: $valid)
                                       
                                
                                }
                                
                            
                        }
                            }
                        }
                    }
                }
                
            }
        }
        .textFieldStyle(MyTextFieldStyle())
        .foregroundColor(.white)
        .alert(isPresented: $alert, content: {
            Alert(title: Text(apiError.error), message: Text(apiError.error_description))
        })
        .onChange(of: code) { value in
            self.validate()
        }
        .onAppear {
            
          
           
        }
        }
    }
    }
    
    func validate() {
        self.valid = !code.isEmpty
    }
}

struct EnterPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        EnterPasswordView(isEmail: false, emailDetail: PrimaryEmailAcc(email: "", password: "", note: "", deleteAccount: false), phoneDetail: PrimaryPhone(id: 0, name: "", phoneNum: "", pincode: "", deviceUnlockCode: ""))
    }
}
