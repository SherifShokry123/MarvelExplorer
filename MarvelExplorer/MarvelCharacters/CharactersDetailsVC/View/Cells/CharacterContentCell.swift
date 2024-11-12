//
//  CharacterContentCell.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 12/11/2024.
//

import UIKit

class CharacterContentCell: UICollectionViewCell {
    @IBOutlet private weak var contentTitleLabel: UILabel!
    @IBOutlet private weak var contentImageView: UIImageView!
    
    func setData(title: String, imageURL: String) {
        contentTitleLabel.text = title
        contentImageView.contentMode = .scaleAspectFit
        guard let url = URL(string: imageURL) else { return }
        
        guard contentImageView.image == nil else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Decode the JSON response into your model
            do {
                let decoder = JSONDecoder()
                let marvelCharacterResponse = try decoder.decode(MarvelResponse.self, from: data)
                
                // Extract the image URL from the first character (if it exists)
                if let character = marvelCharacterResponse.data.results.first {
                    let imageURL = character.thumbnail.imageURL
                    DispatchQueue.mainAsyncIfNeeded { [weak self] in
                        self?.contentImageView.loadImage(from: imageURL)
                    }
                    print("Image URL: \(imageURL)")
                }
            } catch {
                print("Error decoding response: \(error)")
            }
        }.resume()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentImageView.image = nil
    }
}
