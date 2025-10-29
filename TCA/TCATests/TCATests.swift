//
//  TCATests.swift
//  TCATests
//
//  Created by wooseob on 10/22/25.
//

import Testing
@testable import TCA
internal import ComposableArchitecture

@MainActor
struct TCATests {
   @Test
   func basics() async {
      let store = TestStore(initialState: Feature.State(count: 0)) {
         Feature()
      }
      
      await store.send(.incrementButtonTapped) {
         $0.count = 1
      }
   }
}
