//
//  CharacterInfoCell.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 12/11/2024.
//

import Foundation
import UIKit

class CharacterInfoCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    
    func setData(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
