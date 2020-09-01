//
//  View1.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 05/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI

struct View3: View {
    @ObservedObject var viewModel: ViewModel3
//    @ObservedObject var state: NavigationState

    var body: some View {
//        NavigationView {
            VStack {
                Text("Sample View 3")
                Button(action: {
                    self.viewModel.showDetails()
                }, label: {
                    Text("Show Details Again")
                })

//                FlowLinkView(action: {
//                    self.viewModel.showDetails()
//                }, state: state,
//                   buttonLabel: {
//                    Text("Show Details")
//                })
            }
//        }
    }
}


//struct View1_Previews: PreviewProvider {
//
//    static var previews: some View {
//        View1(viewModel: ViewModel1(accountId: "sdfsdfsdf"))
//
//    }
//}