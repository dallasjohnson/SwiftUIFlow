//
//  View2.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 05/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI
import Combine

struct CountDownTimer: View {
    var message: String
    @State var counter: Int

    private let timer = Timer.publish(every: 0.001,
                                      on: .main,
                                      in: .common).autoconnect()

    var body: some View {
        Text("\(message)\(counter)")
            .onReceive(timer) { (pub) -> Void in
                if self.counter > 0 {
                    self.counter -= 1
                }
        }
    }
}

struct Flow2View1: View {
    @ObservedObject var viewModel: Flow2ViewModel1
    @State private var buttonTapped = false

    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Flow 2 View 1")
                Text("View model data: \(viewModel.accountId)")
                if buttonTapped {
                    CountDownTimer(message: "time: ", counter: TimeDelayConstant)
                }
                Button(action: {
                    self.buttonTapped = true
                    self.viewModel.showDetails()
                }, label: {
                    Text(viewModel.buttonLabel)
                })
            }
        }
    }
}

struct Flow2View1_Previews: PreviewProvider {
    static var previews: some View {
        Flow2View1(viewModel: Flow2ViewModel1())
    }
}
