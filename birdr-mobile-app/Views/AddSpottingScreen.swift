//
//  AddSpottingScreen.swift
//  birdr-mobile-app
//
//  Created by Justin Reusch on 8/24/21.
//

import SwiftUI
import Combine
import BirdrAPIClient
import BirdrFoundation
import BirdrModel

struct AddSpottingScreen: View {
    
    @ObservedObject var api: SpottingScreenPublisher = .init(context: .init())
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var imageKeys: Set<String> = []
    
    @State private var errorMessage: String? = nil
    
    @State private var bird: BirdPicker = .americanRobin
    
    // TODO: Temp
    private enum BirdPicker: Int, RawRepresentable, CaseIterable, Codable, CustomStringConvertible {
        case americanRobin
        case blackNoddy
        case blueAndYellowMacaw
        case blueJay
        case houseSparrow
        case longTailedBroadbill
        case northernCardinal
        
        var description: String { identification.description }
        
        var identification: BirdIdentification {
            switch self {
            case .americanRobin: return .americanRobin
            case .blackNoddy: return .blackNoddy
            case .blueAndYellowMacaw: return .blueAndYellowMacaw
            case .blueJay: return .blueJay
            case .houseSparrow: return .houseSparrow
            case .longTailedBroadbill: return .longTailedBroadbill
            case .northernCardinal: return .northernCardinal
            }
        }
        
        var image: UIImage {
            switch self {
            case .americanRobin: return UIImage(named: "robin")!
            case .blackNoddy: return UIImage(named: "black-noddy")!
            case .blueAndYellowMacaw: return UIImage(named: "macaw")!
            case .blueJay: return UIImage(named: "blue-jay")!
            case .houseSparrow: return UIImage(named: "sparrow")!
            case .longTailedBroadbill: return UIImage(named: "long-tailed-broadbill")!
            case .northernCardinal: return UIImage(named: "cardinal")!
            }
        }
    }
    
    var statusDisplay: some View {
        var color: Color = .primary
        switch api.currentStatus {
        case .ok:
            color = .green
        case .waiting(for: _, since: let date):
            color = date.timeIntervalSinceNow > 5 ? .red : .gray
        case .error(_):
            color = .red
        }
        return (
            VStack{
                Text("Status:")
                    .font(.headline)
                VStack {
                    Text(api.statusMessage)
                        .foregroundColor(color)
                }
                .padding(8)
            }
            .frame(width: 300, height: 88, alignment: .center)
            .background(Color(.displayP3, red: 0.5, green: 0.5, blue: 0.5, opacity: 0.2))
            .cornerRadius(16)
            .padding()
        )
    }
    
    var body: some View {
        VStack {
            Spacer(minLength: 32)
            Text("Enter information about the bird you spotted...")
            Form {
                Section(header: Text("Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
                Section(header: Text("Bird Information")) {
                    Picker(
                        selection: $bird,
                        label: Text("What type of bird did you see?"),
                        content: {
                            ForEach(BirdPicker.allCases, id: \.self) {
                                Text($0.description)
                            }
                        }
                    ).pickerStyle(WheelPickerStyle())
                }
            }
            if let knownErrorMessage = errorMessage {
                VStack {
                    Text("Error:")
                        .font(.headline)
                        .foregroundColor(.red)
                    Text(knownErrorMessage)
                        .font(.body)
                        .foregroundColor(.red)
                    Button(
                        action: {
                            errorMessage = nil
                        },
                        label: {
                            Text("Dismiss")
                        }
                    )
                }
            }
            if title.count > 0 {
                Button(
                    action: {
                        do {
                            try api.add(image: bird.image) { result in
                                switch result {
                                case .success(_):
                                    do {
                                        try api.createSpotting(
                                            title: title,
                                            bird: bird.identification,
                                            location: Location(
                                                latitude: 36.364473,
                                                longitude: -94.198723
                                            ),
                                            timestamp: getCurrentUnixTimestamp(),
                                            description: description
                                        )
                                    } catch {
                                        errorMessage = String(describing: error)
                                    }
                                case .failure(let error):
                                    errorMessage = String(describing: error)
                                }
                            }
                        } catch {
                            errorMessage = String(describing: error)
                        }
                    },
                    label: {
                        Text("Submit spotting")
                    }
                )
            }
            Spacer()
            statusDisplay
            Spacer()
            if let spotting = api.spotting {
                NavigationLink(
                    destination: BirdSpottingDisplay(
                        spotting: spotting,
                        images: [api.lastUIImage]
                    ),
                    label: {
                        Text("See your spotting!")
                    }
                )
            }
            Spacer()
        }
        .navigationBarTitle("Add Bird Spotting")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddSpottingScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddSpottingScreen()
        }
            .preferredColorScheme(.dark)
    }
}
