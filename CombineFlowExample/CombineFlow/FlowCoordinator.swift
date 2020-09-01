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

class FlowHostingViewController<Content: View>: UIHostingController<Content> {
    //    var didDismissPublisher = PassthroughSubject<Void, Never>()
    //
    //    override func willMove(toParent parent: UIViewController?) {
    //        super.willMove(toParent: parent)
    //        if parent == nil {
    //            handleDismiss()
    //        }
    //    }
    //
    //    func handleDismiss(){
    //        didDismissPublisher.send(())
    //    }
}

extension UINavigationController {
    var topPresentedNavController: UINavigationController {
        guard let vc = presentedViewController as? UINavigationController else {
            return self
        }
        return vc.topPresentedNavController
    }
}

extension UIViewController {
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

class FlowCoordinator: ObservableObject {
    @Published public var flowContributor = FlowContributor.none
    @Published public var rootNavigationController = UINavigationController()

    private var flowStack: [Flow] = []
    private var presentingNavController: UIViewController?
    private var currentNavController: UIViewController?
    @Published private var stepTransition: AppStep?
    @Published private var viewPresentation: ViewPresentation?

    private var cancellables = Set<AnyCancellable>()

    init() {

        // Connect the flowContributors into either viewPresentation or navTransitions
        $flowContributor
            .sink(receiveValue: { (flowContributor) in
                switch flowContributor {
                    case .contribute(let withNextFlow, let startingStep):
                        // Save the presenting View controller at the start of a new flow in case pop to parent flow is called later.
                        self.presentingNavController = self.currentNavController
                        self.flowStack.append(withNextFlow)
                        self.stepTransition = startingStep
                    case .forwardToCurrentFlow(withStep: let withStep):
                        self.stepTransition = withStep
                    case .popToParentFlow(withStep: let withStep):
                        guard let presentingVC = self.presentingNavController else { fatalError("No presenting VC")}
                        self.rootNavigationController.popToViewController(presentingVC,
                                                                          animated: true)
                        _ = self.flowStack.popLast()
                        guard self.flowStack.last != nil else {
                            fatalError("Cannot pop to parent without a parent available")
                        }
                        self.stepTransition = withStep
                    case .view(let viewPres):
                        self.viewPresentation = viewPres
                    case .pop(let animated):
                        let topVC = self.rootNavigationController.topPresentedNavController
                        if topVC.isModal {
                            topVC.dismiss(animated: animated, completion: nil)
                        } else {
                            guard let presentNavVC = self.currentNavController?.parent as? UINavigationController else { fatalError("No parent Nav VC")}
                            presentNavVC.popViewController(animated: animated)
                    }
                    case .multiple(let contributions):
                        for contribution in contributions {
                            self.flowContributor = contribution
                    }
                    case .none:
                        ()
                }
            })
            .store(in: &cancellables)

        // Connect the Step Publisher from within each view to stepTransitions
        $viewPresentation
            .compactMap { $0 }
            .flatMap { $0.presentable.stepPublisher }
            .sink(receiveValue: { [weak self] (step) in
                self?.stepTransition = step
            })
            .store(in: &self.cancellables)

        // Connect the stepTransitions via the flow's navigate() to flowContributors
        $stepTransition
            .compactMap { $0 }
            .map { self.flowStack.last!.navigate(to: $0) }
            .switchToLatest()
            .assign(to: \.flowContributor, on: self)
            .store(in: &cancellables)
        
        // Connect the viewPresentations to the UI rendering
        $viewPresentation
            .compactMap { $0 }
            .sink(receiveValue: { (pres) in
                let vc = FlowHostingViewController(rootView: pres.presentable.createView())
                // Save the current view controller so that it can be used as a base to pop to when popping to parent flow
                self.currentNavController = vc
                switch pres.type {
                    case .root:
                        self.rootNavigationController.viewControllers = [vc]
                    case .push:
                        let nav = self.rootNavigationController.topPresentedNavController
                        nav.pushViewController(vc, animated: true)
                    case .modal:
                        self.rootNavigationController.present(vc,
                                                              animated: true,
                                                              completion: nil)
                    case .modalWithPush:
                        let modalNav = UINavigationController(rootViewController: vc)
                        let nav = self.rootNavigationController.topPresentedNavController
                        nav.present(modalNav, animated: true, completion: nil)
                }
            })
            .store(in: &cancellables)
    }
}
