//
//  MarvelCharacterViewCell.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 11/11/2024.
//

import UIKit
import Kingfisher

class MarvelCharacterViewCell: UITableViewCell {
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var characterNameLabel: UILabel!
    
    func setData(marvelCharacter: MarvelCharacter) {
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.loadImage(from: marvelCharacter.thumbnail.imageURL)
        characterNameLabel.text = marvelCharacter.name
    }
    
    override func prepareForReuse() {
        characterImageView.image = nil
    }
}
