//
//  MainImageCell.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 12/11/2024.
//

import Foundation
import UIKit

class MainImageCell: UITableViewCell {
    @IBOutlet private weak var mainImageView: UIImageView!
    var backAction: (() -> Void)?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(marvelCharacter: MarvelCharacter) {
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.loadImage(from: marvelCharacter.thumbnail.imageURL)
    }
    
    @IBAction private func backPressed(sender: UIButton) {
        backAction?()
    }
}
