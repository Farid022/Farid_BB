//
//  AestheticView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/14/22.
//

import SwiftUI

struct AestheticView: View {
    @StateObject private var aestheticViewModel = AestheticViewModel()
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
                        Text("Esthétique")
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
                           
                            Text("Voici mes volontés concernant l’esthétique de ma cérémonie")
                                   .font(.system(size: 22))
                                   .fontWeight(.bold)
                                   .padding(.top,40)
                                   .padding(.bottom,40)
                                   .padding(.leading,24)
                        
                            CoffinView(aesthetic: aestheticViewModel.asthetic)
                                .padding(.bottom,40)
                                .cornerRadius(24)
                            
                            ItemWithTitleListDescription(title: "Mes demandes concernant la décoration", description: aestheticViewModel.asthetic[0].special_decoration_note ?? "", items: [])
                                .padding(.bottom,40)
                            
                            ItemWithTitleListDescription(title: "Mes souhaits concernant la tenue des invités", description: aestheticViewModel.asthetic[0].attendence_dress_note ?? "", items: [])
                                .padding(.bottom,40)
                            
                            ItemWithTitleListDescription(title: "Mes souhaits sur les accessoires à faire porter aux invités", description: aestheticViewModel.asthetic[0].guest_accessories_note ?? "", items: [])
                                .padding(.bottom,40)
                            
                        }
                    }
                }
            }
        }
        .onAppear {
            aestheticViewModel.getAesthetic { success in
                
            }
        }
    }
}
struct CoffinView: View
{
    var aesthetic: [Aesthetic]
    var body: some View {
        ZStack{
            Color.init(red: 242/255, green: 242/255, blue: 247/255)
                
           
            VStack(alignment:.leading)
            {
                
                Text("Mes fleurs")
                       .font(.system(size: 20))
                       .fontWeight(.bold)
                       .padding(.top,40)
                       .padding(.bottom,40)
                       .padding(.leading,24)
              
                    
                    ForEach(enumerating: aesthetic, id:\.self)
                    {
                        index, item in
                       
                        FlowerItem(title: item.flower?.name ?? "", description: item.flower_note ?? "", image: item.flower?.image ?? "")
                    }
                  
              
                
                
                
                
            }
        }
        .padding(.leading,18)
        .padding(.trailing,18)
        
    }
}


struct FlowerItem: View
{
    var title: String
    var description: String
    var image: String
    var body: some View {
        
        VStack(alignment:.leading)
        {
            Text("+ " + title)
                   .font(.system(size: 15))
                   .fontWeight(.bold)
                  
                   .padding(.bottom,24)
            
            if image.count > 0
            {
                AsyncImage(url: URL(string: image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .padding(.bottom,24)
                .cornerRadius(22)
                .frame(width: 161, height: 207)
            }
            if description.count > 0
            {
            HStack(alignment:.top){
                Image("ic_note")
              
                Text(description)
                       .font(.system(size: 14))
                       .fontWeight(.regular)
                       .padding(.bottom,40)
                       .padding(.leading,16)
                       .padding(.trailing,24)
                
            }
            }
            
        }
        .padding(.leading,24)
        .padding(.trailing,24)
    }
}



struct AestheticView_Previews: PreviewProvider {
    static var previews: some View {
        AestheticView()
    }
}
