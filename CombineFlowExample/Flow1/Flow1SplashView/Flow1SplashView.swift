//
//  SplashView.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 28/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI

struct Flow1SplashView: View {
    var viewModel: Flow1SplashViewModel
    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Flow 1 Splash View")
                Button(viewModel.buttonLabel) {
                    self.viewModel.showDetails()
                }
            }
        }
    }
}

struct Flow1SplashView_Previews: PreviewProvider {
    static var previews: some View {
        Flow1SplashView(viewModel: Flow1SplashViewModel())
    }
}
