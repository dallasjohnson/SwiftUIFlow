//
//  SplashView.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 28/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI

struct Flow2EntryView: View {
    @ObservedObject var viewModel: Flow2EntryViewModel
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Flow 2 Entry View")
                Text("Passed in data: \(viewModel.accountId)")
                Button(action: {
                    self.viewModel.showDetails()
                }) {
                    Text("Go to the next view")
                }
                Spacer()
            }
        }
    }
}

struct Flow2EntryView_Previews: PreviewProvider {
    static var previews: some View {
        Flow2EntryView(viewModel: Flow2EntryViewModel(accountId: "sample AccountId"))
    }
}
