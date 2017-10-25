//
//  UIImageView+Alamofire.swift
//  PropertyFinder
//
//  Created by Apokrupto on 25/10/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation
import AlamofireImage

extension UIImageView {
    /// Wrapper for Alamofire image download operation
    ///
    /// - Parameters:
    ///   - address: Image URL
    ///   - placeholder: Image to use if no image can be downloaded
    ///   - filter: Filter to apply to image
    ///   - completion: completion handler
    func image(at url: URL, placeholder: UIImage?, completionHandler completion: (() -> Void)?) {
        image = placeholder
        
        let transition = ImageTransition.crossDissolve(.transitionDuration)
        
        af_setImage(withURL: url, placeholderImage: placeholder, filter: nil, imageTransition: transition) { response in
            completion?()
        }
    }
}

private extension TimeInterval {
    static let transitionDuration: TimeInterval = 0.2
}
