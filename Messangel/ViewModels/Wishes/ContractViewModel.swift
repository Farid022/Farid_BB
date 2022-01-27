//
//  ContractViewModel.swift
//  Messangel
//
//  Created by Saad on 1/10/22.
//

import Foundation

struct ContractLocal: Codable {
    var contract_name: String
    var contract_organization: Int
    var contract_note: String
    var user: Int
}

struct ContractSever: Hashable, Codable {
    let id: Int
    let user: User
    let name, note: String
    let organization: Organization

    enum CodingKeys: String, CodingKey {
        case id, user
        case name = "contract_name"
        case note = "contract_note"
        case organization = "contract_organization"
    }
}

class ContractViewModel: ObservableObject {
    @Published var orgs = [Organization]()
    @Published var contracts = [ContractSever]()
    @Published var contract = ContractLocal(contract_name: "", contract_organization: 0, contract_note: "", user: getUserId())
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func create(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: contract, response: contract, endpoint: "users/\(getUserId())/contract") { result in
            switch result {
            case .success(let contract):
                DispatchQueue.main.async {
                    self.contract = contract
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
    
    func getAll() {
        APIService.shared.getJSON(model: contracts, urlString: "users/\(getUserId())/contract") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.contracts = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getOrgs() {
        APIService.shared.getJSON(model: orgs, urlString: "choices/\(getUserId())/organization?type=4") { result in
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
}
