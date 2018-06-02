//
//  UIImageViewExt.swift
//  BBCap
//
//  Created by Hai Phung N.T. on 6/1/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SDWebImage
import Async

extension UIImageView {

    typealias Completion = (UIImage?) -> Void

    func setImage(urlString: String?, placeholder: UIImage? = nil, completion: Completion? = nil) {
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
                image = placeholder
                return
        }
        sd_setImage(with: url,
                    placeholderImage: placeholder,
                    progress: nil) { [weak self] (image, _, _, _) in
                        guard let this = self else { return }
                        Async.main {
                            this.image = image
                            completion?(image)
                        }
        }
    }
}
