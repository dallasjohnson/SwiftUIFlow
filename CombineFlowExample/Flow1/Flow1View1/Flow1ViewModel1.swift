//
//  ViewModel1.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 07/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Combine
import SwiftUI

class Flow1ViewModel1: Presentable, ObservableObject {
    func createView() -> AnyView { AnyView(Flow1View1(viewModel: self)) }

    var stepPublisher = PassthroughSubject<AppStep, Never>()

    @Published var buttonLabel: String = "Action Button Label"

    func showDetails() {
        buttonLabel = "ActionButton has been tapped"
        //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(200)) {
        self.stepPublisher.send(ExampleAppSteps.step2Required(username: "username to login") )
        //        }
    }
}
