//
//  ViewModel1.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 07/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Combine
import SwiftUI

class Flow2EntryViewModel: Presentable, ObservableObject {
    func createView() -> AnyView { AnyView(SplashView2(viewModel: self)) }
    var intentPublisher = PassthroughSubject<Intent, Never>()

    func showDetails() {
        self.intentPublisher.send(ExampleAppIntents.flow2View1Requested(username: "Flow2 intent 2 account ID", firstName: "Fred"))
    }
}
