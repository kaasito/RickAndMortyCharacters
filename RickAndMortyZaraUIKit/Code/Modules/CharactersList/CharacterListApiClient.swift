//
//  CharacterListApiClient.swift
//  RickAndMortyZaraUIKit
//
//  Created by Lucas Romero Magaña on 11/9/23.
//

import Foundation
import Alamofire
import Combine

class CharacterListApiClient: BaseAPIClient{
    func getAllCharactersInit() -> AnyPublisher<CharacterListDto, BaseError> {
        requestPublisher(relativePath: Endpoints.authorize, method: .get, parameters: nil, urlEncoding: JSONEncoding.default, type: CharacterListDto.self)
    }
}
