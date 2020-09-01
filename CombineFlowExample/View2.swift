//
//  View2.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 05/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI

struct View2: View {
    @ObservedObject var viewModel: ViewModel2
//    @ObservedObject var state: NavigationState

    var accountId: String

    var body: some View {
//        NavigationView {
        VStack {
            Text("Sample View 2")
            Text("Details : \(accountId)")
            Button(action: {
                self.viewModel.showSecondDetails()
            }, label: {
                Text("Show second detials")
            })

//            FlowLinkView(action: {
//                self.viewModel.showSecondDetails()
//            }, state: state) {
//                Text("Show second detials")
//            }
        }
//        }
    }
}

//struct View2_Previews: PreviewProvider {
//    static var previews: some View {
//        View1(viewModel: ViewModel1( accountId: "sdfsdfsdf"))
//    }
//}
