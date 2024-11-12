//
//  RelatedLinksCell.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 12/11/2024.
//

import UIKit

class RelatedLinksCell: UITableViewCell {
    @IBOutlet private weak var linksStackView: UIStackView!
    @IBOutlet private weak var comicsLinkView: UIView!
    @IBOutlet private weak var wikiLinkView: UIView!
    @IBOutlet private weak var detailsLinkView: UIView!
    var marvelCharacter: MarvelCharacter?
    var openWebView: ((URL) -> Void)?
    
    func setData(marvelCharacter: MarvelCharacter) {
        self.marvelCharacter = marvelCharacter
        marvelCharacter.urls.forEach { url in
            switch url.type {
            case "detail":
                detailsLinkView.isHidden = false
            case "comiclink":
                comicsLinkView.isHidden = false
            case "wiki":
                wikiLinkView.isHidden = false
            default:
                break
            }
        }
    }
    
    @IBAction func detailsURLAction(sender: UIButton) {
        guard let detailURLStr = marvelCharacter?.urls.filter({ $0.type == "detail" }).first?.url, let detailURL = URL(string: detailURLStr) else { return }
        openWebView?(detailURL)
    }
    
    @IBAction func comicsURLAction(sender: UIButton) {
        guard let comicsURLStr = marvelCharacter?.urls.filter({ $0.type == "comiclink" }).first?.url, let comicsURL = URL(string: comicsURLStr) else { return }
        openWebView?(comicsURL)
    }
    
    @IBAction func wikiURLAction(sender: UIButton) {
        guard let wikiURLStr = marvelCharacter?.urls.filter({ $0.type == "wiki" }).first?.url, let wikiURL = URL(string: wikiURLStr) else { return }
        openWebView?(wikiURL)
    }
    
    
}
