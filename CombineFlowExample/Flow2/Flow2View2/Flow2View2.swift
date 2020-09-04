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
    @State var isLoading = false
    
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Flow 2 View 2")
                if isLoading {
                    ActivityIndicator(isAnimating: .constant(true), style: .medium)
                }
                Text("Account ID: \(viewModel.accountId)")
                Button(action: {
                    self.isLoading = true
                    self.viewModel.showDetails()
                }, label: {
                    Text("Complete Flow 2")
                })
            }
        }
    }
}

struct Flow2View2_Previews: PreviewProvider {
    static var previews: some View {
        Flow2View2(viewModel: Flow2ViewModel2())
    }
}
