//
//  CharacterListViewModel.swift
//  RickAndMortyZaraUIKit
//
//  Created by Lucas Romero Magaña on 11/9/23.
//

import Combine

class CharacterListViewModel {

    // MARK: - Properties
    private var dataManager: CharacterListDataManager
    private let state: CurrentValueSubject<CharacterListState, Never> = .init(.loading)
    private var cancellables: Set<AnyCancellable> = []
    private var charactersList: [CharacterListDecorator]?
    private var filteredCharactersList: [CharacterListDecorator]?
    private var isFiltering: Bool = false
    
    // MARK: - Object lifecycle
    init(dataManager: CharacterListDataManager) {
        self.dataManager = dataManager
    }

    // MARK: - Public Methods
    func getState() -> AnyPublisher<CharacterListState, Never> {
        return state.eraseToAnyPublisher()
    }
    
    func getCharacterList() -> [CharacterListDecorator] {
        
        if isFiltering{
            return filteredCharactersList ?? []
        }
        
        return charactersList ?? []
    }
    
    func loadData() {
        dataManager.getAllCharacters().sink(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                print(error)
            }
        },receiveValue: {
            self.handlerCategories(characterItems: $0)
        })
        .store(in: &cancellables)
    }

    func filterCharacterList(_ filteredText: String, isEmpty: Bool) {
        guard let charactersList = charactersList else { return }
        let filteredData = charactersList.filter { $0.characterName.lowercased().contains(filteredText.lowercased()) }
        isEmpty ? state.send(.success(charactersList)) : state.send(.success(filteredData))
        filteredCharactersList = filteredData
        isFiltering = !isEmpty
    }

    // MARK: - Private Methods
    private func handlerCategories(characterItems: [Character]) {
        let characterDecorators = characterItems.compactMap({CharacterListDecorator(
            characterName: $0.name,
            status: $0.status,
            image: $0.image,
            species: $0.species,
            type: $0.type == "" ? "-" : $0.type,
            gender: $0.gender,
            origin: $0.origin.name,
            location: $0.location.name) })
        self.charactersList = characterDecorators
        state.send(.success(characterDecorators))
    }
}

enum CharacterListState {
    case loading
    case success([CharacterListDecorator])
}
