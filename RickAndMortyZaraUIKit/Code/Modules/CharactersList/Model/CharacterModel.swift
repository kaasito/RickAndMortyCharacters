//
//  CharacterModel.swift
//  RickAndMortyZaraUIKit
//
//  Created by Lucas Romero Magaña on 11/9/23.
//

import Foundation

struct CharacterListDto: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Location: Codable {
    let name: String
    let url: String
}
