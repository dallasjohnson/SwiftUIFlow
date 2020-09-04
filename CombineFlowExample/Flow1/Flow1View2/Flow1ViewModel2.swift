//
//  ViewModel2.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 08/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI
import Combine

class Flow1ViewModel2: Presentable, ObservableObject {
    func createView() -> AnyView { AnyView(Flow1View2(viewModel: self, accountId: "sdfsdf")) }

    var stepPublisher = PassthroughSubject<AppStep, Never>()

    @Published var buttonLabel: String = "Action Button Label"

    func showSecondDetails() {
        buttonLabel = "ActionButton has been tapped"
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(2000)) {
        self.stepPublisher.send(ExampleAppSteps.step3Required)
//        }
    }
}
