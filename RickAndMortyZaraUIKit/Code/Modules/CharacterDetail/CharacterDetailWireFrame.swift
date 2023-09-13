//
//  CharacterDetailWireFrame.swift
//  RickAndMortyZaraUIKit
//
//  Created by Lucas Romero Magaña on 13/9/23.
//

import Foundation
import UIKit

class CharacterDetailWireFrame {

    // MARK: - Properties
    private var characterListDecorator: CharacterListDecorator
    
    private var viewController: CharacterDetailViewController {
        let viewController: CharacterDetailViewController = CharacterDetailViewController(nibName: "CharacterDetailView", bundle: nil)
        let viewModel: CharacterDetailViewModel = CharacterDetailViewModel(characterListDecorator: self.characterListDecorator)
        viewController.set(viewModel: viewModel)
        return viewController
    }

    // MARK: - LifeCycle
    init(characterListDecorator: CharacterListDecorator) {
        self.characterListDecorator = characterListDecorator
    }

    // MARK: - Public Methods
    func push(navigation: UINavigationController? ) {
        guard let navigation = navigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }

}


