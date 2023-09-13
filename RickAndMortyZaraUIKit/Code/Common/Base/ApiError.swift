//
//  ApiError.swift
//  RickAndMortyZaraUIKit
//
//  Created by Lucas Romero Magaña on 13/9/23.
//

import Foundation

final class ApiError: Codable, Error {
    let localizedMessage: String?
    let errorCode: String?

    init(errorCode: String?, localizedMessage: String?) {
        self.errorCode = errorCode
        self.localizedMessage = localizedMessage
    }
}
