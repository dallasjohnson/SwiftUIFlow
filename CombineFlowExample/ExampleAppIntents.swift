//
//  ExampleAppIntents.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 01/09/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Foundation

/// This is an example flow and potentially each UX flow could have their own Intent type to facilitate navigation. In most cases it would make sense for this to be an enum since it could switch in the `navigate` method of a flow but it doesn't need to be.
enum ExampleAppIntents: Intent, Equatable {
    case initialLaunch
    case flow1View1Requested
    case flow1View2Requested(accountId: String)
    case flow1View2Completed
    case flow1RequestFlow2(accountId: String)
    case flow2InitialLaunch(accountId: String)
    case flow2View1Requested(accountId: String, firstName: String)
    case flow2View2Requested(accountId: String, firstName: String, lastName: String)
    case flow2Completed(accountId: String)
}
