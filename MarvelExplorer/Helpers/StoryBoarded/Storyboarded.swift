//
//  Storyboarded.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 12/11/2024.
//

import UIKit.UIStoryboard
import UIKit.UIViewController

public extension UIViewController {
    static var defaultNib: String {
        return description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }

    static var storyboardIdentifier: String {
        return description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }

    internal var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (navigationController?.navigationBar.frame.height ?? 0.0)
    }
}

extension UIStoryboard {
    class func instantiateInitialViewController(_ id: Storyboard) -> UIViewController {
        let story = UIStoryboard(name: id.rawValue, bundle: nil)
        return story.instantiateInitialViewController()!
    }
}

public enum Storyboard: String {
    case Main

    public func viewController<VC: UIViewController>(_: VC.Type) -> VC {
        guard
            let vc = UIStoryboard(name: rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC
        else { fatalError("Couldn't instantiate \(VC.storyboardIdentifier) from \(rawValue)") }

        return vc
    }

    public func initialViewController() -> UIViewController {
        let story = UIStoryboard(name: rawValue, bundle: nil)
        guard let vc = story.instantiateInitialViewController() else { fatalError("\(rawValue) has no InitialViewController") }
        return vc
    }
}
