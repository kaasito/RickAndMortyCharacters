//
//  CharacterListWireFrame.swift
//  RickAndMortyZaraUIKit
//
//  Created by Lucas Romero Magaña on 11/9/23.
//

import Foundation
import UIKit

class CharacterListWireFrame {

    // MARK: - Properties
    private var viewController: CharacterListViewController {
        let viewController: CharacterListViewController = CharacterListViewController(nibName: "CharacterListView", bundle: nil)
        let dataManager: CharacterListDataManager = createDataManager(apiClient: apiClient)
        let viewModel: CharacterListViewModel = createViewModel(with: dataManager)
        viewController.set(viewModel: viewModel)
        return viewController
    }
    
    private var apiClient: CharacterListApiClient {
        return CharacterListApiClient()
    }

    // MARK: - Private methods
    
    private func createViewModel(with dataManager: CharacterListDataManager) -> CharacterListViewModel {
        return CharacterListViewModel(dataManager: dataManager)
    }
    
    private func createDataManager( apiClient: CharacterListApiClient) -> CharacterListDataManager {
        let dataManager = CharacterListDataManager(apiClient: apiClient)
        return dataManager
    }

    // MARK: - Public methods
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }
    
    func present() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        if appDelegate.window == nil {
            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        }
        let navigationController = UINavigationController(rootViewController: viewController)
        appDelegate.window?.rootViewController = navigationController
        appDelegate.window?.backgroundColor = .white
        appDelegate.window?.makeKeyAndVisible()
    }
}
