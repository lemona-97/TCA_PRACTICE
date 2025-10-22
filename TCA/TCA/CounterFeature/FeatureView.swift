//
//  FeatureView.swift
//  TCA
//
//  Created by wooseob on 10/22/25.
//

import SwiftUI
import ComposableArchitecture
internal import UniformTypeIdentifiers

struct FeatureView: View {
   let store: StoreOf<Feature>
   
   var body: some View {
      Form {
         Section {
            Text("\(store.count)")
            Button("Decrement") { store.send(.decrementButtonTapped) }
            Button("Increment") { store.send(.incrementButtonTapped) }
         }
         Section {
            Button("random dog") { store.send(.randomDogButtonTapped) }
         }
         
         if
            let urlString = store.randomDogImageUrl,
            let url = URL(string: urlString) {
            Text("\(url)")
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable().scaledToFit()
                      .clipShape(Circle())
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    EmptyView()
                }
            }
         }
      }
   }
}


#Preview {
   FeatureView(store: Store(initialState: Feature.State(), reducer: {
      Feature()
   }))
}
