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
    func createView() -> AnyView { AnyView(Flow1View2(viewModel: self)) }

    var intentPublisher = PassthroughSubject<Intent, Never>()
    var shouldLaunchedFlow2: Bool

    init(shouldLaunchedFlow2: Bool) {
        self.shouldLaunchedFlow2 = shouldLaunchedFlow2
    }

    @Published var accountId: String = "12AJDJ-SFHSJK232-SF"
    @Published var isLoading = false

    func showDetails() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(TimeDelayConstant)) {
            if self.shouldLaunchedFlow2 {
                self.intentPublisher.send(ExampleAppIntents.flow1RequestFlow2(accountId: self.accountId))
            } else {
                self.intentPublisher.send(ExampleAppIntents.flow1View2Completed)
            }
            self.isLoading = false
        }
    }
}
