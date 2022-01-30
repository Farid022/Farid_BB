//
//  FuneralMusicArtist.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI

struct FuneralMusicArtist: View {
    @ObservedObject var vm: FuneralMusicViewModel
    static let title = "Indiquez le nom de l’artiste"
    var body: some View {
        FlowBaseView(menuTitle: "Musique", title: FuneralMusicArtist.title, valid: .constant(!vm.music.artist_name.isEmpty), destination: AnyView(FuneralMusicTitle(vm: vm))) {
           TextField("Artiste", text: $vm.music.artist_name)
            .normalShadow()
        }
        .onDidAppear {
            if !vm.updateRecord, let music: FuneralMusic = Utils.getData("music") {
                vm.music = music
            }
        }
    }
}


