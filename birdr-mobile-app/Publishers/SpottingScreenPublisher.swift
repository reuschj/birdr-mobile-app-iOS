//
//  SpottingScreenPublisher.swift
//  birdr-mobile-app
//
//  Created by Justin Reusch on 8/24/21.
//

import SwiftUI
import Combine
import BirdrAPIClient
import BirdrServiceModel
import BirdrFoundation
import BirdrModel

class SpottingScreenPublisher: ObservableObject {
    var api: BirdrAPI
    
    init(context: BirdrAPIContext = .init()) {
        self.api = BirdrAPI(context: .init())
    }
    
    enum AddSpottingError: Error, CustomStringConvertible {
        case eventInProgress(event: String, since: Date)
        case invalidImageData(UIImage)
        
        var description: String {
            switch self {
            case .eventInProgress(event: let event, since: let date):
                return "Another event is already in progress: \"\(event)\" for \(date.timeIntervalSinceNow) seconds (since \(date))."
            case .invalidImageData(let image):
                return "The image passed, \(image.description), did not contain usable data."
            }
        }
    }
    
    enum Status: CustomStringConvertible {
        case ok
        case waiting(for: String, since: Date = Date())
        case error(Error)
        
        var description: String {
            switch self {
            case .ok:
                return "Ok"
            case .waiting(for: let event, since: let date):
                return "Waiting for the event \"\(event)\" for \(date.timeIntervalSinceNow) seconds (since \(date))."
            case .error(let error):
                return String(describing: error)
            }
        }
    }
    
    var statusMessage: String { currentStatus.description }
    
    @Published var currentStatus: Status = .ok
    
    @Published var imageKeys: Set<String> = []
    @Published var lastImageKey: String? = nil
    @Published var imageData: [String: ImageStore] = [:]
    
    var lastImage: ImageStore? {
        lastImageKey.flatMap { imageData[$0] }
    }
    var lastUIImage: UIImage? {
        lastImage.flatMap { UIImage(data: $0.data) }
    }
    
    @Published var spotting: BirdSpotting? = nil
    @Published var spottingKey: String? = nil
    
    private func checkForWaitingStatus() throws -> Void {
        switch self.currentStatus {
        case .waiting(for: let event, since: let date):
            throw AddSpottingError.eventInProgress(event: event, since: date)
        default:
            return
        }
    }
    
    func add(
        image: UIImage,
        forceAdd: Bool = false,
        completionHandler: BirdrImageAPI.CreateHandler? = nil
    ) throws -> Void {
        if !forceAdd {
            try checkForWaitingStatus()
        }
        guard let data = image.pngData() else {
            throw AddSpottingError.invalidImageData(image)
        }
        self.currentStatus = .waiting(for: "add image request", since: Date())
        api.image.create(data: data) { [weak self] result in
            switch result {
            case .success(let imageStoreReturn):
                self?.lastImageKey = imageStoreReturn.key
                self?.imageKeys.insert(imageStoreReturn.key)
                self?.imageData[imageStoreReturn.key] = imageStoreReturn.storedImage
                self?.currentStatus = .ok
            case .failure(let error):
                self?.currentStatus = .error(error)
            }
            completionHandler?(result)
        }
    }
    
    func createSpotting(
        title: String,
        bird: BirdIdentification,
        location: Location? = nil,
        timestamp: Int? = nil,
        description: String? = nil,
        forceAdd: Bool = false,
        completionHandler: BirdrSpottingAPI.CreateHandler? = nil
    ) throws -> Void {
        if !forceAdd {
            try checkForWaitingStatus()
        }
        let spotting: BirdSpotting = .init(
            title: title,
            imageKeys: imageKeys,
            bird: bird,
            location: location,
            timestamp: timestamp,
            description: description
        )
        api.spotting.create(with: spotting) { [weak self] result in
            switch result {
            case .success(let birdSpottingReturn):
                self?.spotting = birdSpottingReturn.spotting
                self?.spottingKey = birdSpottingReturn.key
                self?.currentStatus = .ok
            case .failure(let error):
                self?.spotting = nil
                self?.spottingKey = nil
                self?.currentStatus = .error(error)
            }
            completionHandler?(result)
        }
    }
}
