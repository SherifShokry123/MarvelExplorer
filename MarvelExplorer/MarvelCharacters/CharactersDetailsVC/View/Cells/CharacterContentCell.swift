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
    
    func setData(title: String, image: UIImage?) {
        contentTitleLabel.text = title
        contentImageView.contentMode = .scaleAspectFit
        contentImageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentImageView.image = nil
    }
    
    func loadImage(from urlString: String, completion: @escaping ((UIImage?) -> Void)) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                debugPrint("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let marvelCharacterResponse = try decoder.decode(MarvelResponse.self, from: data)
                
                if let character = marvelCharacterResponse.data.results.first {
                    let imageURL = character.thumbnail.imageURL
                    DispatchQueue.mainAsyncIfNeeded { [weak self] in
                        self?.contentImageView.loadImage(from: imageURL, onComplete: { result in
                            
                            let retrivedImage: UIImage? = (try? result.get())?.image
                            completion(retrivedImage)
                        })
                        
                    }
                }
            } catch {
                debugPrint("Error decoding response: \(error)")
            }
        }.resume()
    }
}
