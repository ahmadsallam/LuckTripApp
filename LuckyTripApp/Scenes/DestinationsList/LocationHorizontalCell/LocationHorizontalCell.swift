//
//  LocationHorizontalCell.swift
//  LuckyTripApp
//
//  Created by Ahmad Sallam on 17/08/2022.
//

import UIKit
import WebKit

class LocationHorizontalCell: UICollectionViewCell {

    @IBOutlet weak var wkWebView: WKWebView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
