//
//  ViewController.swift
//  LuckyTripApp
//
//  Created by Ahmad Sallam on 17/08/2022.
//

import UIKit

class DestinationsListViewController: UIViewController {

    @IBOutlet weak var saveLocationButton: UIButton!
    @IBOutlet weak var destinationsListCollectionView: UICollectionView!
    
    var model: DestinationsListViewModel = DestinationsListViewModel()
    var selectedLocation: [Location] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addChangeHandler()
        setupSaveButton()
        model.loadDestinationsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateStateSaveButton()
    }
    
    //MARK: - Changes Handler
    
    func addChangeHandler(){
        model.addChangeHandler { [weak self] (chnage) in
            switch chnage {
            case .loaded:
                self?.destinationsListCollectionView.reloadData()
                //Here can hide the loading on screen
            case .loading:
                //Here start with show loading on screen
                break
            }
        }
    }
    
    //MARK: - Setup Methods
    
    func setupSaveButton(){
        saveLocationButton.layer.cornerRadius = 8
    }
    
    func setupCollectionView(){
        destinationsListCollectionView.delegate = self
        destinationsListCollectionView.dataSource = self
        destinationsListCollectionView.register(UINib(nibName: "DestinationCell", bundle: nil), forCellWithReuseIdentifier: "DestinationCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        destinationsListCollectionView.collectionViewLayout = layout
    }

    //MARK: - Actions

    @IBAction func saveLocationAction(_ sender: Any) {
        var newToSave = try? UserDefaults.standard.getObject(forKey: "SelectedLocation", castTo: [Location].self)
        newToSave?.append(contentsOf: selectedLocation)
        try? UserDefaults.standard.saveObject(newToSave, forKey: "SelectedLocation")
        selectedLocation.removeAll()
        updateStateSaveButton()
        destinationsListCollectionView.reloadData()
    }
    
    //MARK: - Helper
    
    func updateStateSaveButton(){
        if selectedLocation.count == 3 {
            saveLocationButton.isHidden = false
        } else {
            saveLocationButton.isHidden = true
        }
    }
    
}


extension DestinationsListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.state.destinationsCountryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DestinationCell", for: indexPath) as! DestinationCell
        cell.countryName.text = model.state.destinationsCountryArray[indexPath.row]
        let city = model.state.destinationsCityArray[model.state.destinationsCountryArray[indexPath.row]] ?? []
        cell.cityArray = city
        cell.placesCollectionView.reloadData()
        cell.delegate = self
        cell.selectedLocationArray = selectedLocation
        return cell
    }
    
}

extension DestinationsListViewController: DestinationCellDelegate {
    
    func didSelectLocation(location: Location,cell: DestinationCell) {
        guard selectedLocation.count < 3 else {
            selectedLocation.removeAll(where: {$0.id == location.id})
            cell.selectedLocationArray = selectedLocation
            updateStateSaveButton()
            return
        }
        selectedLocation.append(location)
        cell.selectedLocationArray = selectedLocation
        updateStateSaveButton()
    }
    
    
}

extension DestinationsListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: 300)
    }
}
