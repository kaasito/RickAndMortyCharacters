//
//  CharacterListDataManager.swift
//  RickAndMortyZaraUIKit
//
//  Created by Lucas Romero Magaña on 11/9/23.
//

import Combine
import Foundation
import Alamofire

class CharacterListDataManager {
    // MARK: - Properties
    private var apiClient: CharacterListApiClient
    private var reference: String?
    
    // MARK: - Object lifecycle
    init(apiClient: CharacterListApiClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - Public Method
    func getAllCharacters() -> AnyPublisher<[Character], BaseError> {
        getAllcgaractersInit().eraseToAnyPublisher()
    }
    
    func getAllcgaractersInit() -> AnyPublisher<[Character], BaseError> {
        apiClient.getAllCharactersInit().map { characterDTO in
            characterDTO.results
        }
        .eraseToAnyPublisher()
    }
}
