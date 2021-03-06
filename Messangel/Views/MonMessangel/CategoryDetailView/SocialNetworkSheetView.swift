//
//  SocialNetworkSheetView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 3/21/22.
//

import SwiftUI
import NavigationStack

struct SocialNetworkSheetView: View {
    
    var categoryDetail: categoryDetailItem?
    var body: some View {
        NavigationStackView("SocialNetworkSheetView") {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack(spacing: 0.0) {
                Color.accentColor
                    .ignoresSafeArea()
                    .frame(height: 5)
                NavBar()
                    .overlay(HStack {
                        BackButton()
                        Spacer()
                        Text(categoryDetail?.account_fields?.online_service?.name ?? "")
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
                           
                            Text(categoryDetail?.account_fields?.online_service?.name ?? "")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,0)
                                   .padding(.leading,24)
                            
                            Text("Accès")
                                   .font(.system(size: 17))
                                   .fontWeight(.bold)
                                   .padding(.top,24)
                                   .padding(.bottom,0)
                                   .padding(.leading,24)
                            
                            HStack
                            {
                                Image("ic_key_color_native")
                                    .frame(width:26,height:13)
                            
                                Text(categoryDetail?.account_fields?.mail_account?.primary_email ?? "")
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       
                                      
                                       .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,24)
                            
                            HStack
                            {
                                Image("ic_mobile")
                                    .frame(width:26,height:13)
                            
                                Text(categoryDetail?.account_fields?.smartphone_account?.smartphone_name ?? "")
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       
                                      
                                       .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,24)
                            
                            Text("Gestion")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,0)
                                   .padding(.leading,24)
                            
                            
                            HStack
                            {
                                Image("ic_link")
                                    .frame(width:26,height:13)
                            
                                Text(categoryDetail?.account_fields?.online_service?.url ?? "")
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       
                                      
                                       .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,24)
                            
                            
                            HStack
                            {
                                Image("ic_i")
                                    .frame(width:26,height:13)
                            
                                Text("*Clôturer immédiatement/*Mettre un message (" +  (categoryDetail?.leave_msg_time ?? "") + ")")
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       .lineLimit(2)
                                       
                                      
                                       .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,24)
                            
                           
                            if categoryDetail?.last_post_note?.count ?? 0 > 0
                            {
                            
                            KeyAccountDetailNoteView(title: "Note", description: categoryDetail?.last_post_note ?? "")
                                .padding(.bottom,24)
                            }
                           
                            Group{
                                
                                if categoryDetail?.last_post_image?.count ?? 0 > 0 {
                            HStack
                            {
                                Image("ic_i")
                                    .frame(width:26,height:13)
                            
                                Text("Ajouter une photo")
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       .lineLimit(2)
                                       
                                      
                                       .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,24)
                            
                            
                            Image("")
                            .padding(.bottom,24)
                            
                                
                            HStack
                            {
                                Image("ic_i")
                                    .frame(width:26,height:13)
                            
                                Text("Clôturer le compte après 1 mois")
                                       .font(.system(size: 15))
                                       .fontWeight(.regular)
                                       .lineLimit(2)
                                       
                                      
                                       .padding(.leading,10)
                                
                                
                            }
                            .padding(.leading,24)
                            .padding(.bottom,24)
                                
                            }
                                
                                HStack
                                {
                                    Image("ic_i")
                                        .frame(width:26,height:13)
                                
                                    if categoryDetail?.memorial_account ?? false == false
                                    {
                                        Text("*J’accepte qu’un compte commémoratif soit créé sur ce réseau social")
                                               .font(.system(size: 15))
                                               .fontWeight(.regular)
                                               .lineLimit(2)
                                               
                                              
                                               .padding(.leading,10)
                                    }
                                    else
                                    {
                                        Text("*Je refuse qu’un compte commémoratif soit créé sur ce réseau social")
                                               .font(.system(size: 15))
                                               .fontWeight(.regular)
                                               .lineLimit(2)
                                               
                                              
                                               .padding(.leading,10)
                                    }
                                   
                                    
                                    
                                }
                                .padding(.leading,24)
                                .padding(.bottom,24)
                                
                            }
                           
                        }
                    }
                }
            }
        }
        .onAppear {
            
           
            
        }
        }
    }
}

struct SocialNetworkSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SocialNetworkSheetView()
    }
}
