//
//  ViewModel1.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 07/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Combine
import SwiftUI

class ViewModel1: Presentable, ObservableObject {
    var flow: ExampleFlow1
    var navState: NavigationState

    @Published var buttonLabel: String = "Action Button Label"
//    @Published var destinationView: AnyView = AnyView(EmptyView())

//    var viewPublisher: AnyPublisher<AnyView, Never>

//    var viewSubject = CurrentValueSubject<AnyView, Never>(AnyView(Text("placcccceeee")))

    //    @EnvironmentObject var navigationView: FlowCoodinator

    //    @Published var firstName: String = ""
    //    @Published var lastName: String = ""

    var cancelables = Set<AnyCancellable>()

    init(flow: ExampleFlow1, navState: NavigationState){
        self.flow = flow
        self.navState = navState
//        viewPublisher = viewSubject.share().eraseToAnyPublisher()
//
//        viewPublisher
//            .print("getting a destinationViw")
//            .sink {
//                print("Seeeititintng the view")
//                self.destinationView = $0
//        }.store(in: &cancelables)
    }

    func showDetails() {
        buttonLabel = "ActionButton has been tapped"
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(2000)) {
            self.flow.triggerDetailsDisplay(currentState: self.navState)
        }
    }
}
