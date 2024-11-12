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
        fadeIn(imageURL: marvelCharacter.thumbnail.imageURL)
        characterNameLabel.text = marvelCharacter.name
    }
    
    func fadeIn(imageURL: String) {
        characterImageView.loadImage(from: imageURL)
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.3,
            options: [],
            animations: {
                self.characterImageView.alpha = 1
            })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        characterImageView.alpha = 0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        characterImageView.image = nil
    }
}

