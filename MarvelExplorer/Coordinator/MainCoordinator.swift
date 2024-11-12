//
//  Coordinator.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 12/11/2024.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}


class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = Storyboard.Main.viewController(MarvelCharactersListVC.self)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navigateToMarvelCharacterDetails(character: MarvelCharacter) {
        let vc = Storyboard.Main.viewController(MarvelCharactersDetailsVC.self)
        vc.coordinator = self
        vc.marvelCharacter = character
        navigationController.pushViewController(vc, animated: true)
    }
}
