//
//  NavigationState.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 09/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Combine
import SwiftUI

enum PresentationStyle {
    case none
    case push
    case modal
}

struct TransitionView<D: View>: View {
    @Binding var isPresented: Bool
    var presentingStyle: PresentationStyle
    var destination: D

    var body: some View {
        switch presentingStyle {
            case .none:
                return AnyView(EmptyView())
            case .push:
                return AnyView(NoLabelNavigationLink(destination: destination,
                                                     isPresented: $isPresented))
            case .modal:
                return AnyView(ModalLink(destination: destination,
                                         isPresented: $isPresented))
        }
    }
}

struct FlowLinkView<L: View>: View {
    var action: () -> ()
    var state: NavigationState
    var buttonLabel: () -> L

    var body: some View {
        Button(action: action) {
            buttonLabel().background(
                TransitionView(isPresented: Binding(get: { self.state.isPresented },
                                                    set: { self.state.isPresented = $0}),
                               presentingStyle: state.destn?.presentingStyle ?? .none,
                               destination: state.destn?.view)
            )
        }
    }
}

class NavigationState: ObservableObject {
    var presentingStyle: PresentationStyle = .push
//    private var flowCoordinator: FlowCoodinator

    @Published var isPresented: Bool = false 
//        willSet(newValue) {
//            if isPresented && !newValue {
////                flowCoordinator.popStateSubject.send(self)
//            }
//        }
        //        didSet {
        //            print("isPresented updated: \(self.view) \(isPresented)")
        //            //            parentNode?.childNode = nil
        //        }
//    }

    //    func transition<D: View>(destView: D) -> TransitionView<D> {
    //        return TransitionView(isPresented: Binding(get: { self.isPresented },
    //                                                   set: { self.isPresented = $0}),
    //                              presentingStyle: destn?.presentingStyle ?? .none,
    //                              destination: destView)
    //    }

    @Published var view: AnyView = AnyView(EmptyView())
    @Published var destn: NavigationState?

    //    @Published var childNode: NavigationState?

    //    func destView() -> AnyView {
    //        guard let childView = childNode?.view else {return AnyView(EmptyView())
    //
    //        }
    //        return AnyView(NavigationLink(destination: childView,
    //                                      isActive: Binding(get: { self.childNode?.isPresented ?? false },
    //                                                        set: { self.childNode?.isPresented = $0})) {
    //                                        Text("Label")
    //        })
    //    }

    //    var parentNode: NavigationState?

    init(presentingStyle: PresentationStyle) {
        self.presentingStyle = presentingStyle
//        self.flowCoordinator = flowCoordinator
    }
}
