//
//  FlowCoordinator.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 07/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

//enum Transition {
//    case present(navState: NavigationState)
//    case pop
//}

class FlowCoodinator: ObservableObject {
    var window: UIWindow

    //    let transitionSubject = PassthroughSubject<Transition, Never>()

//    private var currentNavState: NavigationState? {
//        didSet {
//            print("stateChanged: \(currentNavState)")
//            if let view = currentNavState?.view {
//                window.rootViewController = UIHostingController(rootView: view.environmentObject(self))
//                window.makeKeyAndVisible()
//            } else {
//                window.rootViewController = nil
//            }
//        }
//    }


    //    @Published var states: [NavigationState] = [] {
//        didSet {
//            print("stateChanged: \(states)")
//            if self.window.rootViewController == nil {
//                if let view = states.first?.view {
//                    window.rootViewController = UIHostingController(rootView: view.environmentObject(self))
//                    window.makeKeyAndVisible()
//                }
//            }
//        }
//    }
    //
    //        func pushState(state: NavigationState) {
    //            states.append(state)
    //            //        if let current = currentNavState {
    //            //            current.childNode = state
    //            //            state.parentNode = currentNavState
    //            //            currentNavState = state
    //            //        } else {
    //            //            currentNavState = state
    //            //        }
    //        }
    //
    //        func popState() -> NavigationState? {
    //            return states.popLast()
    //            //        let oldState = currentNavState
    //            //        currentNavState = currentNavState?.parentNode ?? nil
    //            //        return oldState
    //        }

    //    private var transitionSubject: PassthroughSubject<NavigationState?, Never>
    private let flowSubject = PassthroughSubject<Flow, Never>()
    //    var addStateSubject = PassthroughSubject<NavigationState, Never>()
    //    var popStateSubject = PassthroughSubject<NavigationState, Never>()
    //    var viewSubject = PassthroughSubject<AnyView, Never>()

    private var cancellables = Set<AnyCancellable>()

    init(window: UIWindow) {
        self.window = window
        //        self.transitionSubject = PassthroughSubject<NavigationState?, Never>()
        //        self.flowSubject =
        //        self.viewSubject =  PassthroughSubject<AnyView, Never>()

        //        self.flowPublisher = self.flowSubject.share().eraseToAnyPublisher()
        //        nodePublisher = self.nodeSubject.share().eraseToAnyPublisher()
        //        self.viewPublisher = self.viewSubject.share().eraseToAnyPublisher()

        self.flowSubject
            .print("flowSubject -> nodeSubject")
            .flatMap({ flow in
                return flow.navStatePublisher
            })
            .compactMap({ $0 })
            .sink(receiveValue: { (navState) in
                if window.rootViewController == nil {
                    window.rootViewController = UIHostingController(rootView: navState.view.environmentObject(self))
                    window.makeKeyAndVisible()
                }
            })
            //                    .assign(to: \.currentNavState, on: self)
                    .store(in: &cancellables)

        //        flowSubject
        //            .print("flowSubject -> stateSubject")
        //            .flatMap({ flow in
        //                return flow.navStatePublisher
        //            })
        ////            .compactMap({ $0 })
        //            .subscribe(addStateSubject)
        //            .store(in: &cancellables)

        //        addStateSubject
        //            .print("pushState")
        //            .sink {
        //                self.pushState(state: $0)
        //        }.store(in: &cancellables)

        //        popStateSubject
        //            .print()
        //            .sink {_ in
        //                self.popState()
        //        }.store(in: &cancellables)

        //            transitionSubject.sink {
        //                switch $0 {
        //                    case .present(let navState):
        //                        self.pushState(state: navState)
        //                    case .pop:
        //                        self.popState()
        //                }
        //            }.store(in: &cancellables)
    }

    func startWith(flow: Flow) {
        flowSubject.send(flow)
        
    }


    //        stateSubject
    //            .flatMap { navState in
    //                return navState.$view
    //        }.subscribe(viewSubject)
    //            .store(in: &cancellables)
    //
    //        viewSubject
    //        .print()
    //            .sink { (view) in
    //                if self.window.rootViewController == nil {
    //                    window.rootViewController = UIHostingController(rootView: view.environmentObject(self))
    //                    window.makeKeyAndVisible()
    //                }
    //        }
    //        .store(in: &cancellables)
}

