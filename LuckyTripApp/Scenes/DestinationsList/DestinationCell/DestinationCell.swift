//
//  DestinationCell.swift
//  LuckyTripApp
//
//  Created by Ahmad Sallam on 17/08/2022.
//

import UIKit
import Nuke

struct Location: Codable {
    var cityName: String
    var imageThumbnail: Thumbnail?
    var video: DestinationVideo?
    var id: Int?
    var countryName: String
    
    var imageUrl: URL? {
        if let url = imageThumbnail?.imageUrl {
            return URL(string: url) 
        }
        return nil
    }
    
    var videoUrl: URL? {
        if let url = video?.url {
            return URL(string: url)
        }
        return nil
    }

}

protocol DestinationCellDelegate: AnyObject {
    func didSelectLocation(location: Location,cell: DestinationCell)
}

class DestinationCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailSavedImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var placesCollectionView: UICollectionView!
    
    var cityArray:[Location] = []
    var selectedLocationArray:[Location] = []
    weak var delegate: DestinationCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()

    }
    
    override func prepareForReuse() {
        cityArray = []
    }
    
    //MARK: - Setup Methods
    
    func setupCollectionView(){
        placesCollectionView.delegate = self
        placesCollectionView.dataSource = self
        placesCollectionView.register(UINib(nibName: "LocationHorizontalCell", bundle: nil), forCellWithReuseIdentifier: "LocationHorizontalCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        placesCollectionView.collectionViewLayout = layout
        placesCollectionView.layer.borderColor = UIColor.lightGray.cgColor
        placesCollectionView.layer.borderWidth = 0.4
        
    }

}

extension DestinationCell: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationHorizontalCell", for: indexPath) as! LocationHorizontalCell
        cell.cityName.text = cityArray[indexPath.row].cityName
        if let url = cityArray[indexPath.row].imageUrl {
            cell.thumbnailImage.loadImage(url: url)
            cell.wkWebView.isHidden = true
        }
        if let videoUrl = cityArray[indexPath.row].videoUrl {
            cell.wkWebView.isHidden = false
            cell.wkWebView.load(URLRequest(url: videoUrl))
        }
        
        if selectedLocationArray.first(where: {$0.id == cityArray[indexPath.row].id}) != nil {
            cell.contentView.backgroundColor = .blue
        } else {
            cell.contentView.backgroundColor = .clear
        }

        return cell
    }
    
}

extension DestinationCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didSelectLocation(location: cityArray[indexPath.row], cell: self)
        placesCollectionView.reloadData()
    }
}

extension DestinationCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.bounds.width / 1.5, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
