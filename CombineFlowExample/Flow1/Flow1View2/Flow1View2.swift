//
//  View2.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 05/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI

struct Flow1View2: View {
    @ObservedObject var viewModel: Flow1ViewModel2

    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Flow 1 View 2")
                Text("View model data: \(viewModel.accountId)")
                if viewModel.isLoading {
                    ActivityIndicator(isAnimating: .constant(true), style: .medium)
                }
                Button(action: {
                    self.viewModel.showDetails()
                }, label: {
                    Text(viewModel.shouldLaunchedFlow2 ? "Go to flow 2 with 2 sec delay" : "Go back with 2 sec delay")
                })
            }
        }
    }
}

struct Flow1View2_Previews: PreviewProvider {
    static var previews: some View {
        Flow1View2(viewModel: Flow1ViewModel2(shouldLaunchedFlow2: true))
    }
}
