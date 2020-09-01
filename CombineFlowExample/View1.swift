//
//  View1.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 05/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI

struct View1: View {
    @ObservedObject var viewModel: ViewModel1

    var body: some View {
        VStack {
            Text("Sample View 1")
            Button(action: {
                self.viewModel.showDetails()
            }, label: {
                Text("Show Details")
            })
        }
        .tabItem {
            Text("Hello")
        }
    }
}


//struct View1_Previews: PreviewProvider {
//
//    static var previews: some View {
//        View1(viewModel: ViewModel1(accountId: "sdfsdfsdf"))
//
//    }
//}
