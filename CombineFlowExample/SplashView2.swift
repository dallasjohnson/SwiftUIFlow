//
//  SplashView.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 28/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI

struct SplashView2: View {
    var viewModel: Splash2ViewModel
    var body: some View {
        VStack {
        Text("Splash View2")
        Text(viewModel.buttonLabel)
            Button(action: {
                self.viewModel.showDetails()
            }) {
                Text("Return to parent flow")
            }
        }
    }
}

struct SplashView2_Previews: PreviewProvider {
    static var previews: some View {
        SplashView2(viewModel: Splash2ViewModel(title: "My title"))
    }
}
