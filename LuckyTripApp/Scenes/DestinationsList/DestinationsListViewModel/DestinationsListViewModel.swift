//
//  DestinationsListViewModel.swift
//  LuckyTripApp
//
//  Created by Ahmad Sallam on 17/08/2022.
//

import Foundation


struct DestinationsListViewModelState {
    
    enum Change: StateChnage {
        case loading
        case loaded
    }
    
    var destinationsCountrySet: Set<String> = []
    var destinationsCountryArray: [String] = []
    var destinationsCityArray: [String:[Location]] = [:]
    var destinationsArray: [DestinationModel] = []
}

class DestinationsListViewModel: StatefulViewModel<DestinationsListViewModelState.Change> {
    
    var state = DestinationsListViewModelState()
    
    func loadDestinationsList() {
        emit(change: .loading)
        Networking.shared.request(request: DestinationsRequest()) { [weak self] (response: Result<Destinations>) in
            switch response {
            case .success(let result):
                self?.state.destinationsArray = result.destinations
                self?.prepareCountryForUseInList()
                self?.emit(change: .loaded)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func prepareCountryForUseInList(){
        state.destinationsCountrySet = Set(state.destinationsArray.map({$0.countryName}))
        state.destinationsCountryArray = Array(state.destinationsCountrySet)
        for country in state.destinationsCountryArray {
            prepareLocationForUseInList(countryName: country)
        }
    }
    
    func prepareLocationForUseInList(countryName: String){
        let countryCities = state.destinationsArray.filter({$0.countryName == countryName})
        for _ in countryCities {
            let cities = countryCities.map({$0.city})
            var locationsArray: [Location] = []
            for city in cities {
                let thumbnail = countryCities.first(where: {$0.city == city})?.thumbnail
                let destinationVideo = countryCities.first(where: {$0.city == city})?.destinationVideo
                let id = countryCities.first(where: {$0.city == city})?.id
                let countryName = countryCities.first(where: {$0.city == city})?.countryName ?? ""

                if destinationVideo != nil {
                    let location = Location(cityName: city,
                                            imageThumbnail: nil,
                                            video: DestinationVideo(url: destinationVideo?.url,
                                                                    thumbnail: destinationVideo?.thumbnail),
                                            id: id,
                                            countryName: countryName)
                    locationsArray.append(location)
                } else {
                    let location = Location(cityName: city, imageThumbnail: thumbnail,id: id, countryName: countryName)
                    locationsArray.append(location)
                }
            }
            state.destinationsCityArray[countryName] = locationsArray
        }
    }
}
