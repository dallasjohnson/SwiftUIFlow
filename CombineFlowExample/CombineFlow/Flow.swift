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

protocol Presentable: class {
    var stepPublisher: PassthroughSubject<AppStep, Never> { get }
    func createView() -> AnyView
}

struct ViewPresentation {
    enum PresentingType {
        case root
        case push
        case modal
        case modalWithPush
    }
    
    let presentable: Presentable
    let type: PresentingType
}

protocol Flow {
    func navigate(to destn: AppStep) -> AnyPublisher<FlowContributor, Never>
}

class BaseFlow {
    var stepSubject = PassthroughSubject<AppStep, Never>()
    var cancellables = Set<AnyCancellable>()
}

enum FlowContributor {
    case contribute(withNextFlow: Flow, startingStep: AppStep)
    /// the "withStep" step will be forwarded to the current flow
    case forwardToCurrentFlow(withStep: AppStep)
    /// the "withStep" step will be forwarded to the parent flow
    case popToParentFlow(withStep: AppStep)
    /// A view presentation configuration including a view model, presentation style and view creator
    case view(_ viewPresentable: ViewPresentation)
    /// Dismiss the current view controller
    case pop(ainmated: Bool)
    /// Execute multiple steps in order
    case multiple(contributions: [FlowContributor])
    /// No further navigation for this step
    case none
}

// Examples -------------------------------------

enum AppStep: Equatable {
    case initialLaunch
    case step1Required
    case step2Required(username: String)
    case step3Required
    case step1Flow2Required(accountId: String)
    case step2Flow2Required(username: String, firstName: String)
    case step2Flow2Required(accountId: String)
}
