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

    var stepPublisher = PassthroughSubject<AppStep, Never>()

    @Published var buttonLabel: String = "Splash View Title Button Label"

    func showDetails() {
        buttonLabel = "SplashView has been tapped"
        //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(200)) {
        self.stepPublisher.send(ExampleAppSteps.step1Required)
        //        }
    }
}
