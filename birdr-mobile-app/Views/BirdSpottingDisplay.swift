//
//  BirdSpottingDisplay.swift
//  birdr-mobile-app
//
//  Created by Justin Reusch on 8/24/21.
//

import SwiftUI
import BirdrModel

struct BirdSpottingDisplay: View {
    var spotting: BirdSpotting
    var images: [UIImage?] = []
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer(minLength: 32)
            Text(spotting.title)
                .font(.largeTitle)
                .foregroundColor(.green)
            Spacer(minLength: 56)
            if let description = spotting.description {
                Text(description)
                    .padding()
            }
            Spacer(minLength: 32)
            VStack(alignment: .center) {
                Text(spotting.bird.commonName)
                    .font(.headline)
                if let taxonomy = spotting.bird.taxonomy?.description {
                    Text(taxonomy)
                }
            }.padding()
            VStack {
                GeometryReader { geometry in
                    ForEach(images, id: \.self) {
                        if let uiImage = $0 {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(
                                    width: geometry.size.width,
                                    height: geometry.size.height,
                                    alignment: .center
                                )
                                .scaledToFit()
                        }
                    }
                }
            }
            Spacer(minLength: 32)
            Form {
                TextField("Spotting Key", text: .constant(spotting.identification.uuidString))
                if let imageKey = spotting.imageKeys.first {
                    TextField("Image Key", text: .constant(imageKey))
                }
            }
        }
        .padding()
    }
}

struct BirdSpottingDisplay_Previews: PreviewProvider {
    static var previews: some View {
        BirdSpottingDisplay(
            spotting: .init(
                title: "Look at the Blue Jay I found!",
                bird: .blueJay,
                description: "I was walking behind my house and saw this blue jay in the tree. What a great spot!"
            ),
            images: [
                UIImage(named: "blue-jay")!
            ]
        )
        .preferredColorScheme(.dark)
    }
}
