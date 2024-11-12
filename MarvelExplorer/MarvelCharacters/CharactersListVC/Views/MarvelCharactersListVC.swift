//
//  ViewController.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 11/11/2024.
//

import UIKit
import Combine

final class MarvelCharactersListVC: UIViewController {
    @IBOutlet weak private var marvelCharactersTableView: UITableView!
    
    weak var coordinator: MainCoordinator?
    private lazy var viewModel: MarvelCharactersListViewModel = MarvelCharactersListViewModel()
    private var characters: [MarvelCharacter] = []
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        viewModel.fetchCharactersData()
        setupTableView()
    }
    
    private func bind() {
        viewModel.charactersSubject
            .sink { [weak self] characters in
                guard let self else { return }
                DispatchQueue.mainAsyncIfNeeded { [weak self] in
                    guard let self else { return }
                    self.characters = characters
                    marvelCharactersTableView.reloadData()
                }
            }
            .store(in: &cancellables)
        
        viewModel.listStateSubject
            .sink { [weak self] listState in
                guard let self else { return }
                
                DispatchQueue.mainAsyncIfNeeded { [weak self] in
                    guard let self else { return }
                    
                    switch listState {
                    case .loading:
                        addLoadMoreFooterView()
                    case .empty, .loaded, .failed:
                        removeLoadMoreFooterView()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func addLoadMoreFooterView() {
        let view = LoadMoreTableViewFooter.instanceFromNib()
        view.frame = CGRect(x: 0,
                            y: 0,
                            width: marvelCharactersTableView.frame.size.width,
                            height: 80)
        marvelCharactersTableView.tableFooterView = view
    }
    
    private func removeLoadMoreFooterView() {
        marvelCharactersTableView.tableFooterView = nil
    }
    
    private func setupTableView() {
        marvelCharactersTableView.register(UINib(nibName: "MarvelCharacterViewCell", bundle: nil), forCellReuseIdentifier: "MarvelCharacterViewCell")
        marvelCharactersTableView.delegate = self
        marvelCharactersTableView.dataSource = self
    }
}

extension MarvelCharactersListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.navigateToMarvelCharacterDetails(character: characters[indexPath.row])
    }
    
}

extension MarvelCharactersListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = marvelCharactersTableView.dequeueReusableCell(withIdentifier: "MarvelCharacterViewCell", for: indexPath) as! MarvelCharacterViewCell
        let character = characters[indexPath.row]
        cell.setData(marvelCharacter: character)
        
        return cell
    }
    
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 200
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.startPagination() ? viewModel.fetchMoreCharacters() : ()
    }
}
