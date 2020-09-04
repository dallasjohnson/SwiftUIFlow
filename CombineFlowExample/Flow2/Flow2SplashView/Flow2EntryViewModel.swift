//
//  Flow2EntryView.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 07/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Combine
import SwiftUI

class Flow2EntryViewModel: Presentable, ObservableObject {
    func createView() -> AnyView { AnyView(Flow2EntryView(viewModel: self)) }
    var intentPublisher = PassthroughSubject<Intent, Never>()

    @Published var accountId: String

    init(accountId: String) {
        self.accountId = accountId
    }

    func showDetails() {
        self.intentPublisher.send(ExampleAppIntents.flow2View1Requested(accountId: self.accountId, firstName: "Fred"))
    }
}
