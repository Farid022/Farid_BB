//
//  AestheticViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

struct Aesthetic: Codable {
    var special_decoration_note: String
    var attendence_dress_note: String
    var guest_accessories_note: String
    var flower: Int
    var user: Int
}

class AestheticViewModel: ObservableObject {
    @Published var asthetic = Aesthetic(special_decoration_note: "", attendence_dress_note: "", guest_accessories_note: "", flower: 0, user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: asthetic, response: asthetic, endpoint: "users/\(getUserId())/asthetic") { result in
            switch result {
            case .success(let asthetic):
                DispatchQueue.main.async {
                    self.asthetic = asthetic
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