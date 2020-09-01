//
//  ViewModel1.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 07/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Combine
import SwiftUI

class ViewModel3: Presentable, ObservableObject {
      func createView() -> AnyView { AnyView(View3(viewModel: self)) }

    var stepPublisher = PassthroughSubject<AppStep, Never>()

    @Published var buttonLabel: String = "Action Button Label"

    func showDetails() {
        buttonLabel = "ActionButton 3 has been tapped"
        //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(200)) {
        self.stepPublisher.send(.step1Flow2Required(accountId: "Account ID for flow 2 "))
        //        }
    }
}
