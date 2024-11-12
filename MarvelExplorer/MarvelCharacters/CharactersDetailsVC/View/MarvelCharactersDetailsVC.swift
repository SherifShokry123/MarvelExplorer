//
//  MarvelCharactersDetailsVC.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 12/11/2024.
//

import UIKit
import Combine


class MarvelCharactersDetailsVC: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    weak var coordinator: MainCoordinator?
    var marvelCharacter: MarvelCharacter?
    var sections: [HomeSectionType] = []
    private var cancellables = Set<AnyCancellable>()
    private lazy var viewModel: MarvelCharactersDetailsViewModel = MarvelCharactersDetailsViewModel(marvelCharacter: marvelCharacter!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        bind()
        viewModel.makeDetailSections()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "MainImageCell", bundle: nil), forCellReuseIdentifier: "MainImageCell")
        tableView.register(UINib(nibName: "CharacterInfoCell", bundle: nil), forCellReuseIdentifier: "CharacterInfoCell")
        tableView.register(UINib(nibName: "CharacterContentContainerCell", bundle: nil), forCellReuseIdentifier: "CharacterContentContainerCell")
        tableView.register(UINib(nibName: "RelatedLinksCell", bundle: nil), forCellReuseIdentifier: "RelatedLinksCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func bind() {
        viewModel.detailsSectionsSubject
            .sink { [weak self] sections in
                guard let self else { return }
                DispatchQueue.mainAsyncIfNeeded { [weak self] in
                    guard let self else { return }
                    self.sections = sections
                    tableView.reloadData()
                }
            }
            .store(in: &cancellables)
    }
}

extension MarvelCharactersDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.row] {
        case .mainImage:
            return configureMainImageCell(indexPath: indexPath)
        case let .characterInfo(title, description):
            return configureCharacterInfoCell(title: title,
                                              description: description,
                                              indexPath: indexPath)
            
        case .content(title: let title, contentItems: let contentItems):
            return configureCharacterContentContainerCell(title: title,
                                                          contentItems: contentItems,
                                                          indexPath: indexPath)
        case .relatedLinks:
            return configureRelatedLinksCell(indexPath: indexPath)
        }
    }
    
    private func configureMainImageCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainImageCell", for: indexPath) as! MainImageCell
        guard let marvelCharacter = marvelCharacter else { return UITableViewCell() }
        
        cell.setData(marvelCharacter: marvelCharacter)
        cell.backAction = { [weak self] in
            guard let self else { return }
            navigationController?.popViewController(animated: true)
        }
        
        return cell
    }
    
    private func configureCharacterInfoCell(title: String,
                                            description: String,
                                            indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterInfoCell", for: indexPath) as! CharacterInfoCell
        
        cell.setData(title: title, description: description)
        
        return cell
    }
    
    private func configureCharacterContentContainerCell(title: String,
                                                        contentItems: [ContentSummary],
                                                        indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterContentContainerCell", for: indexPath) as! CharacterContentContainerCell
        
        cell.setData(title: title, contentItems: contentItems)
        
        return cell
    }
    
    private func configureRelatedLinksCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RelatedLinksCell", for: indexPath) as! RelatedLinksCell
        
        cell.setData(marvelCharacter: viewModel.marvelCharacter)
        cell.openWebView = { [weak self] url in
            guard let self else { return }
            coordinator?.openURL(url: url)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
