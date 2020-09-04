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
        VStack {
            Text("Splash View2")
            Button(action: {
                self.viewModel.showDetails()
            }) {
                Text("Go to the next view")
            }
        }
    }
}

struct SplashView2_Previews: PreviewProvider {
    static var previews: some View {
        Flow2EntryView(viewModel: Flow2EntryViewModel())
    }
}
