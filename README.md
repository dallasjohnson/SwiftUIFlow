# ep-chl-ios-swift-ui-flow

The intention of this repo is to explore and demonstrate a way to navigate throughout an iOS app in a modular architecture.
The UX journeys are treated in a modular way with each journey being a `Flow` and the each Flow navigates between screens each represented as a `ViewPresentable` based on logic in the `Flow`. The whole app navigation consists of multiple flows that can be joined together dynamically and the communication link between the flows is provided through an `Intent` type. To coordinate a UX flow together there is a `FlowCoordinator` whose role it is to manage everything from an inital `Flow` and the hand-off and navigation to a subsequent `Flow` in any combination of flows.

The initial hope was to use SwiftUI for all the navigation but the API to navigate from one SwiftUI View to another requires adding a `NavigationLink` dynamically to each view or rendering the whole navigation stack in advance. While I tried for quite a few days to achieve this it was messy and clunky so I reverted to using UIKit with `UINavigationController` and `UIHostingController` to host the SwiftUI. This is not ideal and without it's owne problems but seems to have resulted in a cleaner to use API so far.

## Key Types:

### Flow

This is a class protocol that would handle an atomic user journey eg. "Login" or "Make a payment". This would be the class to hold state that should be passed between views and is responsible for deciding which screen to present next for a given `Intent` based on it's own internal state. It must provide one method:

```swift
    func navigate(to intent: Intent) -> AnyPublisher<FlowDriver, Never>
```

The return type is a publisher so it is flexible enough to handle network calls asyncronously and all errors should handled before returning (hence `Never`) so that the calling `FlowCoordinator` only needs to navigate based on the returned `FlowDriver`.

### Intent

This is only a marker protocol and is deliberately loosely typed to allow multiple `Intent` types to be used throughout an app although often there could just be one needed for the whole app. This could be any type (class, struct or enum) but typically it would be an enum with associated values since that provides a clean way to signal a navigation intent providing different associated values where it makes sense. Since the intents are available to pass between different flows they are reusable in different contexts or ignored by some flows. eg.

```swift
    enum MyIntents: Intent, Equatable {
      case initialLaunch
      case loginRequested
      case validateLogin(username: String, password: String)
      case miRequested(char1: Int, char2: Int, char3: Int)
      case homeScreenRequested(accountId: String)
      case transfer(fromAccountId: String)
  }
```

In the above example a `Login` flow would handle the `loginRequested`, `validateLogin`, `miRequested` case by presenting relevent views but would ignore the `initialLaunch` and might hand-off the `homeScreenRequested` or `transfer` case to an accounts flow or pass it back to the parent flow to handle while being dismissed.

### FlowDriver

The return type from the `navigate` method in a flow is a publisher producing `FlowDriver` instances. This is an enum that provides everything required for the `FlowCoordinator` to navigate between different flows or views:

```swift
    enum FlowDriver {
      case forwardToNewFlow(flow: Flow, intent: Intent)
      /// the "withIntent" step will be forwarded to the current flow
      case forwardToCurrentFlow(withIntent: Intent)
      /// the "withIntent" step will be forwarded to the parent flow
      case popToParentFlow(withIntent: Intent, animated: Bool)
      /// A view presentation configuration including a view model, presentation style and view creator
      case view(_ viewPresentable: Presentable, style: PresentingStyle)
      /// Dismiss the current view controller
      case pop(animated: Bool)
      /// No further navigation for this step
      case none
  }
```

### Presentable

This is a class protocol that would usually be a viewmodel and must provide a `createView` function and an `intentPublisher`. The `createView` function will be used
by the `FlowCoordinator` to create a view for navigation based the style in the `FlowDriver.view` case (see the enum above). the `intentPublisher` is subscribed to by the FlowCoordinator as a view is presented to listen to events triggered from the view such as button taps and this then drives the navigation to the current flow's `navigate` method. As this functions as a viewmodel for a view it would typically have `@Published` vars that are used in the SwiftUI view for other logic specific to this view.

### FlowCoordinator

This class is intended to be used as is and will drive the user's journey. A simple app would only need one instance of this and it would provide a rootNavigationController which all subsequent views would be presented upon. The public interface consists only of a FlowContributor to inject new `Flow` objects to start of the navigation and the `rootNavigationController` typically to attach to the app's window. In the case of a TabViewController UI there would be multiple instances of this class to associate with each tab. Since such an app in effect has multiple live journeys based on each tab.
For convienience there are the `TabBarNavCoordinator` and `MasterDetailCoordinator` classes to provide a starter for the relevent UI styles.

## Conclusion

By breaking the UX flow into this architecture the intention was to be able to separate the navigation decision logic from the actual navigation presentation so that transitions between multiple flows with Presentables and Intents could be unit tested without needing to render the UI. It would only require the test to assert of the expected outcome of `navigate` method for a given state and `Intent`.

_Once this is thoroughly tested then will be converted into a SPM module so that it can be used by other apps and also hide away internal classes from public access._