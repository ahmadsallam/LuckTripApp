//
//  File.swift
//  LuckyTripApp
//
//  Created by Ahmad Sallam on 17/08/2022.
//

import Foundation
import Nuke


extension UIImageView {
    
    func loadImage(url: URL){
        let options = ImageLoadingOptions(
          placeholder: UIImage(named: "placeholder"),
          transition: .fadeIn(duration: 0.5)
        )
        Nuke.loadImage(with: url,options: options, into: self)

    }
}
