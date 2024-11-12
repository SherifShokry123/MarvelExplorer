//
//  UIScrollView+Pagination.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 12/11/2024.
//

import UIKit

extension UIScrollView {
    func startPagination() -> Bool {
        guard isDragging else { return false }
        let offsetY = contentOffset.y
        guard offsetY > 0 else { return false }
        let contentHeight = contentSize.height - CGFloat(prefetchRange)
        return offsetY > contentHeight - frame.height ? true : false
    }

    private var prefetchRange: Int {
        return 32 // helps us to start loading the next page before reaching to the end of the list
    }
}
