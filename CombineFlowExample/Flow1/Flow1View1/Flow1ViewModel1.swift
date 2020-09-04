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

    var intentPublisher = PassthroughSubject<Intent, Never>()

    func showDetails() {
        self.intentPublisher.send(ExampleAppIntents.flow1View2Requested(accountId: "username to login") )
    }
}
