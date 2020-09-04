//
//  View2.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 05/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI

struct Flow2View2: View {
    @ObservedObject var viewModel: Flow2ViewModel2

    var body: some View {
        VStack {
            Text("Flow 2 View 2")
            Text("Account ID: \(viewModel.accountId)")
            Button(action: {
                self.viewModel.showDetails()
            }, label: {
                Text("Show details")
            })
        }
    }
}

struct Flow2View2_Previews: PreviewProvider {
    static var previews: some View {
        Flow2View2(viewModel: Flow2ViewModel2())
    }
}
