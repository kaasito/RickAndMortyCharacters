//
//  ViewController.swift
//  RickAndMortyZaraUIKit
//
//  Created by Lucas Romero Magaña on 11/9/23.
//

import UIKit
import Combine

class CharacterListViewController: BaseViewController {

    // MARK: - Properties

    private enum Constants {
        static var searchBarPlaceholder = "Type something"
        static var appendSection = 0
        static var heighForRow = 120.0
    }
    
    typealias TableViewSnapShot = NSDiffableDataSourceSnapshot<Int, CharacterListDecorator>
    private var viewModel: CharacterListViewModel?
    var cancellables: Set<AnyCancellable> = []

    @IBOutlet weak var tvCharacters: UITableView!
    @IBOutlet weak var sbCharacters: UISearchBar!
    
    private var tableViewSnapshot: TableViewSnapShot!
    private var tableViewDataSource: UITableViewDiffableDataSource<Int, CharacterListDecorator>!
    
    // MARK: - Object lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configTableView()
        responseViewModel()
        viewModel?.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sbCharacters.searchTextField.attributedPlaceholder = NSAttributedString(string: Constants.searchBarPlaceholder)
    }
    
    
    // MARK: Public Methods
    func set(viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Private metohds
    private func configView() {
        tvCharacters.delegate = self
        sbCharacters.delegate = self
        tvCharacters.register(UINib(nibName: CharacterListCell.nibName, bundle: nil), forCellReuseIdentifier: CharacterListCell.identifier)
        self.hideKeyboardWhenTappedAround()
    }
    
    private func responseViewModel() {
        viewModel?.getState().sink(receiveValue: { [weak self] catalogState in
            guard let self = self else { return }
            switch catalogState {
            case .loading:
                self.showLoading()
                return
            case .success(let categoryList):
                self.reloadTableView(categoryList: categoryList)
                self.hideLoading()
            }
        }).store(in: &cancellables)
    }
    
    private func configTableView() {
        tableViewDataSource = UITableViewDiffableDataSource<Int, CharacterListDecorator>(tableView: tvCharacters) { tableView, _, element in

            guard let cellCategory = tableView.dequeueReusableCell(withIdentifier: CharacterListCell.identifier) as? CharacterListCell else {return UITableViewCell() }

            cellCategory.config(characterElement: element)
            return cellCategory
        }

        tvCharacters.dataSource = tableViewDataSource
        tvCharacters.separatorStyle = .singleLine
        tvCharacters.separatorInset = UIEdgeInsets.zero
    }

    private func reloadTableView(categoryList: [CharacterListDecorator]) {
        tableViewSnapshot = NSDiffableDataSourceSnapshot<Int, CharacterListDecorator>()
        tableViewSnapshot.appendSections([Constants.appendSection])
        categoryList.forEach {tableViewSnapshot.appendItems([$0], toSection: Constants.appendSection)}
        tableViewDataSource.apply(tableViewSnapshot, animatingDifferences: false) { [weak self] in
            self?.tvCharacters.layoutIfNeeded()
        }
    }
}


extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let characterList = viewModel?.getCharacterList()[indexPath.row] {
            CharacterDetailWireFrame(characterListDecorator: characterList).push(navigation: self.navigationController)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heighForRow
    }
}

extension CharacterListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchText.isEmpty ? viewModel?.filterCharacterList(searchText, isEmpty: true) : viewModel?.filterCharacterList(searchText, isEmpty: false)
    }
}
