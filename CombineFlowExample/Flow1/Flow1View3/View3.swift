//
//  View1.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 05/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI

struct Flow1View3: View {
    @ObservedObject var viewModel: ViewModel3

    var body: some View {
            VStack {
                Text("Flow 1 View 3")
                Button(action: {
                    self.viewModel.showDetails()
                }, label: {
                    Text("Show Details Again")
                })
            }
    }
}

struct View3_Previews: PreviewProvider {

    static var previews: some View {
        Flow1View3(viewModel: ViewModel3())

    }
}
