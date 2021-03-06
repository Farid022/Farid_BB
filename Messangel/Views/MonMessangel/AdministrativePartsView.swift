//
//  AdministrativePartsView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/16/22.
//

import SwiftUI

struct AdministrativePartsView: View {
    
    
    @StateObject private var documentViewModel = DocumentViewModel()
    var animalList = ["Pièce d’identité","*NOMDELAPIECE","*NOMDELAPIECE","*NOMDELAPIECE","*NOMDELAPIECE","*NOMDELAPIECE","*NOMDELAPIECE","*NOMDELAPIECE","*NOMDELAPIECE"]
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack(spacing: 0.0) {
                Color.accentColor
                    .ignoresSafeArea()
                    .frame(height: 5)
                NavBar()
                    .overlay(HStack {
                        BackButton()
                        Spacer()
                        Text("Pièce administratives")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()

                    }
                    .padding(.trailing)
                    .padding(.leading))
                
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                    ScrollView {
                        VStack(alignment:.leading){
                           
                            Text("Voici les versions numérisées de mes pièces administratives ")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,40)
                                   .padding(.leading,24)
                         
                            ZStack{
                                Color.init(red: 242/255, green: 242/255, blue: 247/255)
                                    .ignoresSafeArea()
                               
                                VStack(alignment:.leading)
                                {
                                    
                                    Text("Cette liste contient mes pièces pour les démarches administratives ainsi que d’éventuelles informations complémentaires.")
                                           .font(.system(size: 15))
                                           .fontWeight(.regular)
                                           .multilineTextAlignment(.leading)
                                           .padding(.leading,24)
                                           .padding(.top,40)
                                           .padding(.bottom,40)
                                          
                                }
                                
                            }
                            .cornerRadius(24)
                            .padding(.leading,18)
                            .padding(.trailing,18)
                            
                            VStack{
                            
                                ForEach(enumerating: documentViewModel.documentUpload, id:\.self)
                            {
                                index, item in
                                ListItemImageTitle(type: "ic_partslist", item: item.name)
                                   

                            }
                            .padding(.trailing,24)
                            .padding(.leading,24)
                           
                            }
                            
                           
                            
                        }
                    }
                }
            }
        }
        .onAppear {
            documentViewModel.getAll()
        }
    }
}

struct AdministrativePartsView_Previews: PreviewProvider {
    static var previews: some View {
        AdministrativePartsView()
    }
}
