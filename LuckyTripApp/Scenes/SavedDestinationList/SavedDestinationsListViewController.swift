//
//  SavedDestinationsListViewController.swift
//  LuckyTripApp
//
//  Created by Ahmad Sallam on 17/08/2022.
//

import UIKit

class SavedDestinationsListViewController: UIViewController {

    @IBOutlet weak var savedSelectedCollection: UICollectionView!
    
    var selectedLocation: [Location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSavedLocation()
    }
    
    func getSavedLocation(){
        do {
            selectedLocation = try UserDefaults.standard.getObject(forKey: "SelectedLocation", castTo: [Location].self)
            savedSelectedCollection.reloadData()
        } catch {
            
        }
    }
    
    
    func setupCollectionView(){
        savedSelectedCollection.delegate = self
        savedSelectedCollection.dataSource = self
        savedSelectedCollection.register(UINib(nibName: "DestinationCell", bundle: nil), forCellWithReuseIdentifier: "DestinationCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        savedSelectedCollection.collectionViewLayout = layout
    }



}


extension SavedDestinationsListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedLocation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DestinationCell", for: indexPath) as! DestinationCell
        cell.countryName.text = "\(selectedLocation[indexPath.row].countryName) \(selectedLocation[indexPath.row].cityName)"
        cell.thumbnailSavedImage.isHidden = false
        if let url = selectedLocation[indexPath.row].imageUrl {
            cell.thumbnailSavedImage.loadImage(url: url)
        }
        return cell
    }
    
}

extension SavedDestinationsListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: 300)
    }
}

