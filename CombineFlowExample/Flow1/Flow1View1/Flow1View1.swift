//
//  View1.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 05/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI

struct Flow1View1: View {
    @ObservedObject var viewModel: Flow1ViewModel1
    
    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Flow 1 View 1")
                Button(action: {
                    self.viewModel.showDetails()
                }, label: {
                    Text("Show View 2")
                })
            }
        }
    }
}

struct Flow1View1_Previews: PreviewProvider {
    
    static var previews: some View {
        Flow1View1(viewModel: Flow1ViewModel1())
        
    }
}
