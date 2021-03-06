//
//  AnimalsView.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/14/22.
//

import SwiftUI
import NavigationStack

struct AnimalsView: View {
    @StateObject private var animalsViewModel = AnimalsViewModel()
    @EnvironmentObject private var navigationModel: NavigationModel
    var animalList = ["Snoop","Animal 2","Animal 3","Animal 4","Animal 5","Animal 6","Animal7"]
    var body: some View {
        NavigationStackView("AnimalsView") {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            VStack(spacing: 0.0) {
                Color.accentColor
                    .ignoresSafeArea()
                    .frame(height: 5)
                NavBar()
                    .overlay(HStack {
                        BackButton()
                        Spacer()
                        Text("Animaux")
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
                           
                            Text("Voici mes volontés concernant la transmission de mes animaux")
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
                                    
                                    Text("Cette liste de mes animaux contient les coordonnées des organismes/personnes auxquels je souhaite les transmettre.")
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
                            
                                ForEach(enumerating: animalsViewModel.animals, id:\.self)
                            {
                                index, item in
                                ListItemImageTitle(type: item.animal_photo, item: item.animal_name)
                                    .onTapGesture {
                                        navigationModel.pushContent("AnimalsView") {
                                            
                                            AnimalDetailView(animal: item)
                                        }
                                        
                                    }
                                   

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
            animalsViewModel.getAll()
        }
        }
    }
      
 
}

struct ListItemImageTitle: View
{
    var placeholder: String?
    var type: String
    var item: String
    var body: some View {
        
        VStack
        {
        HStack(alignment:.center)
        {
            
            if type.count > 0
            {
                AsyncImage(url: URL(string: type)) { image in
                    image
                    .resizable()
                    .scaledToFill()
                } placeholder: {
                    Image(placeholder ?? "")
                    .resizable()
                    .clipShape(Circle())
                    .padding(.leading,24)
                    .frame(width:56,height:56)
                }
                .padding(.leading,24)
                .clipShape(Circle())
                .frame(width:56,height:56)
             
                Text(item)
                       .font(.system(size: 15))
                       .fontWeight(.regular)
                       .multilineTextAlignment(.center)
                       .padding(.leading,12)
                
            }
            else
            {
                Image("animalPlaceholder")
                .resizable()
                .clipShape(Circle())
                .padding(.leading,24)
                .frame(width:56,height:56)
                
               
                Text(item)
                       .font(.system(size: 15))
                       .fontWeight(.regular)
                       .multilineTextAlignment(.center)
                       .padding(.leading,24)
            
             
                }
           
            Spacer()
            Rectangle()
            .foregroundColor(.white)
            .padding(.trailing,24)
            
        }
        .frame(height:96)
        .background(.white)
        .cornerRadius(22)
        .shadow(color: Color.init(red: 0, green: 0, blue: 0,opacity: 0.08), radius: 22, x: 0, y: 3)
       
        }
        .frame(height:120)
       
        
    }
}

struct AnimalsView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalsView()
    }
}
