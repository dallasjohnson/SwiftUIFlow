//
//  ViewModel2.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 08/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI
import Combine

class Flow2ViewModel2: Presentable, ObservableObject {
    func createView() -> AnyView { AnyView(Flow2View2(viewModel: self)) }

    var intentPublisher = PassthroughSubject<Intent, Never>()

    @Published var accountId: String = "account id"

    func showDetails() {
        self.intentPublisher.send(ExampleAppIntents.flow2Completed(accountId: accountId))
    }
}
