//
//  LoadMoreTableViewFooter.swift
//  camelan
//
//  Created by Ahmed Ramy on 5/13/20.
//  Copyright © 2020 Camelan. All rights reserved.
//

import UIKit

final class LoadMoreTableViewFooter: UIView {
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.startAnimating()
    }

    class func instanceFromNib() -> LoadMoreTableViewFooter {
        return UINib(nibName: "LoadMoreTableViewFooter", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoadMoreTableViewFooter
    }
}
