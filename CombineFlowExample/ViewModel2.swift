//
//  ViewModel2.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 08/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import Foundation
import SwiftUI

class ViewModel2: Presentable, ObservableObject {
    @Published var destinationView: AnyView = AnyView(EmptyView())
}
