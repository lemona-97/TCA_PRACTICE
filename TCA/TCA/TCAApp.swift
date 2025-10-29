//
//  TCAApp.swift
//  TCA
//
//  Created by wooseob on 10/21/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCAApp: App {
   var body: some Scene {
      WindowGroup {
         FeatureView(
            store: Store(initialState: Feature.State(), reducer: {
               Feature()
            })
         )
      }
   }
}
