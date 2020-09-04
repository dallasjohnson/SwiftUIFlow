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

private class FlowPresentation {
    var viewControllers = [UIViewController]()
    var flow: Flow

    init(flow: Flow) {
        self.flow = flow
    }

    func intentTransition(intent: Intent) -> IntentTransition {
        return IntentTransition(flow: self, intent: intent)
    }
}

private struct IntentTransition {
    var flow: FlowPresentation
    var intent: Intent
}

/// A wrapper struct to encapsulate the presentation of a view including the
private struct ViewPresentation {
    let presentable: Presentable
    let type: PresentingStyle
}

class FlowCoordinator: ObservableObject {
    @Published public var flowContributor = FlowDriver.none
    @Published public var rootNavigationController = UINavigationController()

    private var flowStack: [FlowPresentation] = []
    @Published private var intentTransition: IntentTransition?
    @Published private var viewPresentation: ViewPresentation?
    private var dismissVCPublisher = PassthroughSubject<[UIViewController], Never>()

    private var cancellables = Set<AnyCancellable>()

    init() {

        // Connect the flowContributors into either viewPresentation or navTransitions
        $flowContributor
            .sink(receiveValue: { (flowContributor) in
                switch flowContributor {
                    case .forwardToNewFlow(let flow, let intent):
                        let flowPres: FlowPresentation
                        if let rootFlowPres = self.flowStack.last {
                            if rootFlowPres.flow === flow {
                                flowPres = rootFlowPres
                            } else {
                                flowPres = FlowPresentation(flow: flow)
                                self.flowStack.append(flowPres)
                            }
                        } else {
                            flowPres = FlowPresentation(flow: flow)
                            self.flowStack.append(flowPres)
                        }
                        self.intentTransition = IntentTransition(flow: flowPres, intent: intent)
                    case .forwardToCurrentFlow(let intent):
                        guard let rootFlowPres = self.flowStack.last else {
                            fatalError("Should not be forward to current flow with there being a currentFlow")
                        }
                        self.intentTransition = rootFlowPres.intentTransition(intent: intent)

                    case .popToParentFlow(withIntent: let intent, let animated):
                        guard
                            let parentFlow = self.flowStack.dropLast().last,
                            let presentingVC = parentFlow.viewControllers.last
                            else {
                                fatalError("Cannot pop to parent without a parent available")
                        }

                        let topNavVC = self.rootNavigationController.topPresentedNavController
                        if topNavVC.isModal {
                            topNavVC.dismiss(animated: animated, completion: {
                                if let intent = intent {
                                    self.intentTransition = self.flowStack.last?.intentTransition(intent: intent)
                                }
                            })
                        } else if topNavVC.viewControllers.contains(presentingVC) {
                            topNavVC.popToViewController(presentingVC,
                                                         animated: animated)
                            if let intent = intent {
                                self.intentTransition = self.flowStack.last?.intentTransition(intent: intent)
                            }                    }
                    case .view(let viewPres, let style):
                        self.viewPresentation = ViewPresentation(presentable: viewPres, type: style)
                    case .pop(let animated):
                        let topNavVC = self.rootNavigationController.topPresentedNavController
                        if topNavVC.isModal {
                            topNavVC.dismiss(animated: animated, completion: nil)
                        } else {
                            topNavVC.popViewController(animated: animated)
                    }
                    case .none:
                        ()
                }
            })
            .store(in: &cancellables)

        // Connect the intent publisher from within each view to intentTransitions
        $viewPresentation
            .compactMap { $0 }
            .flatMap { pres in pres.presentable.intentPublisher
                .map { intent in
                    guard let flowPres = self.flowStack.last else {
                        fatalError("shouldn't get here")
                    }
                    return flowPres.intentTransition(intent: intent)

                }
        }
        .sink(receiveValue: { [weak self] (intent) in
            self?.intentTransition = intent
        })
            .store(in: &self.cancellables)

        // Connect the intentTransitions via the flow's navigate() to flowContributors
        $intentTransition
            .compactMap { $0 }
            .map { $0.flow.flow.navigate(to: $0.intent) }
            .switchToLatest()
            .assign(to: \.flowContributor, on: self)
            .store(in: &cancellables)
        
        // Connect the viewPresentations to the UI rendering
        $viewPresentation
            .compactMap { $0 }
            .sink(receiveValue: { (pres) in
                let vc = FlowHostingViewController(rootView: pres.presentable.createView())
                vc.didDismissPublisher
                    .subscribe(self.dismissVCPublisher)
                    .store(in: &self.cancellables)

                self.flowStack.last?.viewControllers.append(vc)

                // Save the current view controller so that it can be used as a base to pop to when popping to parent flow
                switch pres.type {
                    case .root:
                        self.rootNavigationController.viewControllers = [vc]
                    case .push:
                        let nav = self.rootNavigationController.topPresentedNavController
                        nav.pushViewController(vc, animated: true)
                    case .modal:
                        let nav = self.rootNavigationController.topPresentedNavController
                        nav.present(vc,
                                    animated: true,
                                    completion: nil)
                    case .modalWithPush:
                        let modalNav = FlowNavigationController(rootViewController: vc)
                        modalNav.didDismissPublisher
                            .subscribe(self.dismissVCPublisher)
                            .store(in: &self.cancellables)
                        let nav = self.rootNavigationController.topPresentedViewController
                        nav.present(modalNav, animated: true, completion: nil)
                }
            })
            .store(in: &cancellables)

        dismissVCPublisher
            .sink { (dismissingVCs) in

                for flowPres in self.flowStack.reversed() {
                    flowPres.viewControllers.removeAll { dismissingVCs.contains($0) }

                    if flowPres.viewControllers.isEmpty {
                        print("Popped flow: \(flowPres)")
                        _ = self.flowStack.popLast()
                    }
                }
        }
        .store(in: &cancellables)
    }
}

private class FlowHostingViewController: UIHostingController<AnyView> {
    var didDismissPublisher = PassthroughSubject<[UIViewController], Never>()

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            didDismissPublisher.send([self])
        }
    }
}

private class FlowNavigationController: UINavigationController {
    var didDismissPublisher = PassthroughSubject<[UIViewController], Never>()

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isBeingDismissed {
            didDismissPublisher.send(children)
        }
    }
}

private extension UINavigationController {
    var topPresentedNavController: UINavigationController {
        guard let vc = presentedViewController as? UINavigationController else {
            return self
        }
        return vc.topPresentedNavController
    }
}

private extension UIViewController {
    var topPresentedViewController: UIViewController {
        guard let vc = self as? UINavigationController else {
            return self
        }
        return vc.viewControllers.last?.topPresentedViewController ?? vc.topViewController ?? self
    }
    /**
     returns true only if the viewcontroller is presented.
     */
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            if let parent = parent, !(parent is UINavigationController || parent is UITabBarController) {
                return false
            }
            return true
        } else if let navController = navigationController, navController.presentingViewController?.presentedViewController == navController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }
}
