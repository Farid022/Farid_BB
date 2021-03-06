//
//  MusicViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

struct FuneralMusicItem: Codable {
    var id: Int?
    var artist_name: String
    var song_title: String
    var broadcast_song_note: String
    var user: Int
}

struct MusicItem: Hashable, Codable {
    var id: Int
    var user: User
    var artist_name: String
    var song_title: String
    var broadcast_song_note: String
    var assign_user : [User]?
}

class MusicViewModel: ObservableObject {
    @Published var updateRecord = false
    @Published var musics = [MusicItem]()
    @Published var music = FuneralMusicItem(artist_name: "", song_title: "", broadcast_song_note: "", user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: music, response: music, endpoint: "users/\(getUserId())/music") { result in
            switch result {
            case .success(let music):
                DispatchQueue.main.async {
                    self.music = music
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.error_description)
                    self.apiError = error
                    completion(false)
                }
            }
        }
    }
    
    func getMusics() {
        APIService.shared.getJSON(model: musics, urlString: "users/\(getUserId())/music") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.musics = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func del(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.delete(endpoint: "users/\(getUserId())/song/\(id)/music") { result in
            switch result {
            case .success(_):
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func update(id: Int, completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: music, response: music, endpoint: "users/\(getUserId())/song/\(id)/music", method: "PUT") { result in
            switch result {
            case .success(let music):
                DispatchQueue.main.async {
                    self.music = music
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.error_description)
                    self.apiError = error
                    completion(false)
                }
            }
        }
    }
    
    
}
