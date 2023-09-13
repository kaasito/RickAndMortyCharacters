//
//  BaseError.swift
//  RickAndMortyZaraUIKit
//
//  Created by Lucas Romero Magaña on 13/9/23.
//

import Foundation

enum BaseError: Error {
    case generic
    case noInternetConnection
    case API(ApiError)
    case APIresponse(ApiResponseError)

    func description() -> String {
        var description: String = ""
        switch self {
        case .generic: description = "Unespected Error"
        case .noInternetConnection: description = "You don't have Internet Conection"
        case .API(let apiError):
            description = getAPIDescription(apiError: apiError)
        case .APIresponse(let error):
            description = error.errors.first?.message ?? ""
        }
        return description

    }
    
    private func getAPIDescription(apiError: ApiError) -> String {
        return apiError.localizedMessage ?? "Error insesperado"
    }
}
