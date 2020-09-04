//
//  ViewModel1.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 07/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Combine
import SwiftUI

class Flow1SplashViewModel: Presentable, ObservableObject {
    func createView() -> AnyView { AnyView(Flow1SplashView(viewModel: self)) }

    var intentPublisher = PassthroughSubject<Intent, Never>()

    @Published var buttonLabel: String = "Go to view 1"

    func showDetails() {
        self.intentPublisher.send(ExampleAppIntents.flow1View1Requested)
    }
}
