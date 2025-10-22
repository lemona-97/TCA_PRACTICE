//
//  CounterFeature.swift
//  TCA
//
//  Created by wooseob on 10/21/25.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct Feature {
  @ObservableState
  struct State: Equatable {
     var count = 0
     var randomDogImageUrl: String?
 }
  enum Action {
     case decrementButtonTapped
     case incrementButtonTapped
     case randomDogButtonTapped
     case randomDogResponse(String)
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .decrementButtonTapped:
        state.count -= 1
        return .none

      case .incrementButtonTapped:
        state.count += 1
        return .none

      case .randomDogButtonTapped:
        return .run { send in
          struct DogResponse: Decodable {
            let fileSizeBytes: Int
            let url: String
          }

          let (data, _) = try await URLSession.shared.data(
            from: URL(string: "https://random.dog/woof.json")!
          )
          let decoded = try JSONDecoder().decode(DogResponse.self, from: data)
          await send(.randomDogResponse(decoded.url))
        }

      case let .randomDogResponse(url):
         state.randomDogImageUrl = url
        return .none
      }
    }
  }
}
