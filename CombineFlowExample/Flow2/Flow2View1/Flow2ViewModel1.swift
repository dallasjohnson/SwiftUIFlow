//
//  ViewModel2.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 08/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI
import Combine

class Flow2ViewModel1: Presentable, ObservableObject {
    func createView() -> AnyView { AnyView(Flow2View1(viewModel: self)) }

    var stepPublisher = PassthroughSubject<AppStep, Never>()

    @Published var buttonLabel: String = "Action Button Label"
    @Published var accountId: String = "account id"

    func showDetails() {
        buttonLabel = "ActionButton has been tapped"
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(2000)) {
            self.stepPublisher.send(ExampleAppSteps.flow1View2Completed)
        }
    }
}
