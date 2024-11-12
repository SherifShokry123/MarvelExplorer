//
//  CharacterContentCell.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 12/11/2024.
//

import UIKit

class CharacterContentContainerCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentCollectionView: UICollectionView!
    
    var contentItems: [ContentSummary] = []
    private var imageCache: [IndexPath: UIImage] = [:]
    
    func setData(title: String, contentItems: [ContentSummary]) {
        titleLabel.text = title
        self.contentItems = contentItems
        contentCollectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentCollectionView.register(UINib(nibName: "CharacterContentCell", bundle: nil), forCellWithReuseIdentifier: "CharacterContentCell")
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
    }
}

extension CharacterContentContainerCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return contentItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = contentCollectionView.dequeueReusableCell(withReuseIdentifier: "CharacterContentCell", for: indexPath) as! CharacterContentCell
        let item = contentItems[indexPath.item]
        cell.setData(title: item.name, image: imageCache[indexPath])
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard imageCache[indexPath] == nil else { return } // Skip loading if image is cached
        
        let item = contentItems[indexPath.item]
        (cell as? CharacterContentCell)?.loadImage(from: item.imageResourceURL) { [weak self] image in
            self?.imageCache[indexPath] = image
        }
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 160)
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: - Handle Opening Full Screen Image
    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
