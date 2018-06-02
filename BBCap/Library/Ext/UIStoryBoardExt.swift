//
//  UIStoryBoardExt.swift
//  BBCap
//
//  Created by MBA0105 on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {

    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {

    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIStoryboard {

    enum Storyboard: String {
        case main

        var filename: String {
            return rawValue.capitalized
        }
    }

    static let main: UIStoryboard = UIStoryboard(storyboard: .main)

    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        return viewController
    }

    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
}
