//
//  SplashView.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 28/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI

struct Flow1SplashView: View {
    var viewModel: SplashViewModel
    var body: some View {
        Text("Splash View")
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        Flow1SplashView(viewModel: SplashViewModel())
    }
}
