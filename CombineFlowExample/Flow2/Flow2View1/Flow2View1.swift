//
//  View2.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 05/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI

struct Flow2View1: View {
    @ObservedObject var viewModel: Flow2ViewModel1

    var body: some View {
        VStack {
            Text("Flow 2 View 1")
            Text("Account ID: \(viewModel.accountId)")
            Button(action: {
                self.viewModel.showDetails()
            }, label: {
                Text("Show details")
            })
        }
    }
}

struct Flow2View1_Previews: PreviewProvider {
    static var previews: some View {
        Flow2View1(viewModel: Flow2ViewModel1())
    }
}
