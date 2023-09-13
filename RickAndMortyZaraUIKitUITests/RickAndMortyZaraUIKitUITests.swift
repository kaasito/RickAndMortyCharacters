//
//  RickAndMortyZaraUIKitUITests.swift
//  RickAndMortyZaraUIKitUITests
//
//  Created by Lucas Romero Magaña on 11/9/23.
//

import XCTest

final class RickAndMortyZaraUIKitUITests: XCTestCase {

    func testCharacterListDecoratorType_WhenCreatedEmpty_TypeShouldBeHyphen() {
        let characterDecorator = CharacterListDecorator(
            characterName: "Rick Sanchez",
            status: "Alive",
            image: "https://rickandmortyapi.com/api/character/avatar/779.jpeg",
            species: "Human",
            type: "",
            gender: "Male",
            origin: "Birdperson's Consciousness",
            location: "Birdperson's Consciousness")

        let isHyphenType = characterDecorator.isHyphenType()

        XCTAssertFalse(isHyphenType, "The type var has hyphen")
    }
}


struct CharacterListDecorator {
    let characterName: String
    let status: String
    let image: String
    let species: String
    let type: String
    let gender: String
    let origin, location: String
}

extension CharacterListDecorator {
    func isHyphenType() -> Bool {
        return type == "-"
    }
}
