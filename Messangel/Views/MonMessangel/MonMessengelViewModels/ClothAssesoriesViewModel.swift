//
//  ClothAssesoriesViewModel.swift
//  Messangel
//
//  Created by Muhammad Ali  Pasha on 2/27/22.
//

import Foundation

struct Cloth: Codable {
    var single_clothing: Bool
    var clothing_name: String
    var clothing_contact_detail: Int?
    var clothing_organization_detail: Int?
    var clothing_photo: String
    var clothing_note: String
    var user: Int
}

struct ClothsList: Hashable, Codable {
    var id: Int
    var user: User
    var single_clothing: Bool
    var clothing_photo: String
    var clothing_note: String
    var clothing_organization_detail: Organization?
    var clothing_contact_detail: Contact?
    var clothing_name: String
    var assign_user : [User]?
}

class ClothAssesoriesViewModel: ObservableObject {
    @Published var cloths = [ClothsList]()
    @Published var orgs = [Organization]()
    @Published var clothDonation = Cloth(single_clothing: true, clothing_name: "", clothing_contact_detail: 0, clothing_organization_detail: 0, clothing_photo: "", clothing_note: "", user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func createClothDonation(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: clothDonation, response: clothDonation, endpoint: "users/\(getUserId())/clothing") { result in
            switch result {
            case .success(let clothDonation):
                DispatchQueue.main.async {
                    self.clothDonation = clothDonation
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
    
    func getOrgs() {
        APIService.shared.getJSON(model: orgs, urlString: "choices/\(getUserId())/organization?type=2") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.orgs = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getAll() {
        APIService.shared.getJSON(model: cloths, urlString: "users/\(getUserId())/clothing") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.cloths = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
