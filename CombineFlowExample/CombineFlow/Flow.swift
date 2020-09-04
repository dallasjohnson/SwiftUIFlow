//
//  Flow.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 24/07/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

/// This is a marker protocol only to signify to the flow system that the provided type can be used to help transition navigation states
protocol Intent { }

/// This is the basic protocol definitions for what necessary to be able to present a view/viewcontroller. This would usually be a class that is a view model class for a view.
protocol Presentable: class {
    var intentPublisher: PassthroughSubject<Intent, Never> { get }
    func createView() -> AnyView
}

protocol Flow: class {
    /// This method is a core componenet of the Flow to facilitate navigating with any intent but adapting to the context of whichever flow the coordinator is currently running. This allows intents to be re-used for different contexts.
    func navigate(to intent: Intent) -> AnyPublisher<FlowDriver, Never>
}

enum PresentingStyle {
    case root
    case push
    case modal
    case modalWithPush
}

enum FlowDriver {
    case forwardToNewFlow(flow: Flow, intent: Intent)
    /// the "withIntent" step will be forwarded to the current flow
    case forwardToCurrentFlow(withIntent: Intent)
    /// the "withIntent" step will be forwarded to the parent flow
    case popToParentFlow(withIntent: Intent?, animated: Bool)
    /// A view presentation configuration including a view model, presentation style and view creator
    case view(_ viewPresentable: Presentable, style: PresentingStyle)
    /// Dismiss the current view controller
    case pop(animated: Bool)
    /// No further navigation for this step
    case none
}
