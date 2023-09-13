//
//  Enviroment.swift
//  RickAndMortyZaraUIKit
//
//  Created by Lucas Romero Magaña on 11/9/23.
//

import Foundation

final class Environment {

    // MARK: - Properties
    private let typeFileEnvironment = "plist"
    private let nameFileEnvironment = "Config"
    private let keyEnvironmentURL = "baseURL"
    static let shared = Environment()
    private var plistEnvironment: [String: Any]?
    var baseURL: String {
        guard let baseUrl = plistEnvironment?[keyEnvironmentURL] as? String else { fatalError("Invalid baseURL at plist") }
        return baseUrl
    }
    
    // MARK: - Object LifeCycle
    private init() {
        
        if let path = Bundle.main.path(forResource: nameFileEnvironment, ofType: typeFileEnvironment) {
            plistEnvironment = NSDictionary(contentsOfFile: path) as? [String: AnyObject]
        }
    }
}
