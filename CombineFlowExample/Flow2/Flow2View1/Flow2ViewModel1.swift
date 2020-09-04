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

    var intentPublisher = PassthroughSubject<Intent, Never>()

    @Published var buttonLabel: String = "Go to View 2"
    @Published var accountId: String = "12AJDJ-SFHSJK232-SF"
//    @Published private var time = TimeDelayConstant

    func showDetails() {
//        timer.fire()
        buttonLabel = "ActionButton has been tapped"
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(TimeDelayConstant)) {
            self.intentPublisher.send(ExampleAppIntents.flow2View2Requested(accountId: self.accountId, firstName: "fiRstanememem", lastName: "llaaaastName"))
        }
    }
}
