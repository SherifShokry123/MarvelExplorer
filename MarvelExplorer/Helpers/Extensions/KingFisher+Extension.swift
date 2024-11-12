//
//  KingFisher+Extension.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 12/11/2024.
//

import Kingfisher
import UIKit

extension UIImageView {
    func loadImage(from urlString: String?, placeholder: UIImage? = nil, displayLoader: Bool = true, loaderStyle: UIActivityIndicatorView.Style = .medium, loaderColor: UIColor = .gray, ignoreDownSample: Bool = false, shouldScale: Bool = true, onComplete: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil, downloadTask: ((DownloadTask?) -> Void)? = nil) {
        guard let url = URL(string: urlString ?? "") else { return }
        if displayLoader {
            let customIndicator = KingFisherCustomIndicator()
            customIndicator.activityIndicatorStyle = loaderStyle
            customIndicator.activityIndicatorColor = loaderColor

            kf.indicatorType = .custom(indicator: customIndicator)
        }
        var imageOptions: KingfisherOptionsInfo = [
            .cacheOriginalImage,
            .alsoPrefetchToMemory,
        ]
        if shouldScale {
            imageOptions.insert(.scaleFactor(UIScreen.main.scale), at: 0)
        }
        if ignoreDownSample == false {
            imageOptions.insert(.processor(DownsamplingImageProcessor(size: frame.size)), at: 0)
        }
        let task = kf.setImage(with: url, placeholder: placeholder, options: imageOptions) { (result: Result<RetrieveImageResult, KingfisherError>) in
            onComplete?(result)
        }
        downloadTask?(task)
    }
}

class KingFisherCustomIndicator: Indicator {
    var activityIndicatorStyle: UIActivityIndicatorView.Style = .medium
    var activityIndicatorColor: UIColor = .gray
    lazy var view: IndicatorView = {
        let view = UIActivityIndicatorView(style: activityIndicatorStyle)
        view.color = activityIndicatorColor
        return view
    }()

    func startAnimatingView() {
        (view as! UIActivityIndicatorView).startAnimating()
    }

    func stopAnimatingView() {
        (view as! UIActivityIndicatorView).stopAnimating()
    }

    deinit {
        removeIndicatorView()
    }

    private func removeIndicatorView() {
        DispatchQueue.mainAsyncIfNeeded { [weak view] in
            view?.removeFromSuperview()
        }
    }
}
