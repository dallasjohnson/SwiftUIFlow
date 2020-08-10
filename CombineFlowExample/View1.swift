//
//  View1.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 05/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI

struct View1: View {
//    @EnvironmentObject var flowCoordinator: FlowCoodinator
    @ObservedObject var viewModel: ViewModel1
    @ObservedObject var state: NavigationState

    var body: some View {
        NavigationView {
            VStack {
                Text("Sample View 1")
                FlowLinkView(action: {
                    self.viewModel.showDetails()
                }, state: state,
                   buttonLabel: {
                    Text("MyLabel")
                })
            }

        }






        //            NavigationButton(contentView: Text(viewModel.buttonLabel),
        //                             isPresented: flowCoordinator.viewSubject .childNode.isPresented) { (isPresented) -> AnyView in
        //                return self.navigationState.childNode
        //            }
    }
}


//struct View1_Previews: PreviewProvider {
//
//    static var previews: some View {
//        View1(viewModel: ViewModel1(accountId: "sdfsdfsdf"))
//
//    }
//}
