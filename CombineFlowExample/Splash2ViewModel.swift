//
//  ViewModel1.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 07/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Combine
import SwiftUI

class Splash2ViewModel: Presentable, ObservableObject {
    func createView() -> AnyView { AnyView(SplashView2(viewModel: self)) }

    var stepPublisher = PassthroughSubject<AppStep, Never>()

    @Published var buttonLabel: String

    init(title: String) {
        buttonLabel = title
    }

    func showDetails() {
        buttonLabel = "SplashView has been tapped"
        //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(200)) {
        self.stepPublisher.send(.step2Required(username: "Flow2 step 2 account ID"))
        //        }
    }
}
