//
//  ImageLoader.swift
//  Brandi
//
//  Created by Ryan on 2016. 3. 17..
//  Copyright © 2016년 Brandi. All rights reserved.
//

import Foundation
import SDWebImage

public extension UIImageView {
    // Varia
    // image load wrapper function
    func setImageWithUrl(_ urlString: String?, placeholderImage: UIImage? = nil) {
        self.setImageWithUrl(urlString, placeholderImage: placeholderImage, completion: nil)
    }
    
    func setImageWithUrl(_ urlString: String?, placeholderImage: UIImage? = nil, completion: ((_ image: UIImage, _ url: URL) -> Void)?) {
        self.setImageWithUrlWithOptions(urlString, placeholderImage: placeholderImage, options: [], completion: completion)
    }
    
    func setImageWithUrlWithOptions(_ urlString: String?, placeholderImage: UIImage? = nil, options: SDWebImageOptions, completion: ((_ image: UIImage, _ url: URL) -> Void)?) {
        self.image = nil
        if urlString != nil && urlString!.count > 0 && (urlString!.hasPrefix("http") || (urlString!.hasPrefix("file"))) {
            let url = URL(string: urlString!)
            if url != nil {
                var appendend = options
                appendend.insert(SDWebImageOptions.avoidAutoSetImage)
                sd_setImage(with: url!, placeholderImage: placeholderImage, options: appendend, completed:
                    { image, error, cacheType, url in
                        if image != nil {
                            self.image = image
                            completion?(image!, url!)
                        }
                    }
                )
            }
        } else {
            BrandiLog.errorLog("There is no valid image url")
//            BRFirebaseCrashlytics.writeCrashLog(string: "\(#function):: There is no valid image url")
        }
    }
}
