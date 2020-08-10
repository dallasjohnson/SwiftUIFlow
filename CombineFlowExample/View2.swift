//
//  View2.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 05/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI

struct View2: View {
    @ObservedObject var viewModel: ViewModel2
    var accountId: String

    var body: some View {
        Text("accountId viewkladsljkadsjkladsjkladsjklasdjkladsjkl 1 : \(accountId)")
    }
}

//struct View2_Previews: PreviewProvider {
//    static var previews: some View {
//        View1(viewModel: ViewModel1( accountId: "sdfsdfsdf"))
//    }
//}
