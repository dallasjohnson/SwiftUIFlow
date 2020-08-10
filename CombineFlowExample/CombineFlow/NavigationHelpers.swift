//
//  NavigationHelpers.swift
//  CombineFlowExample
//
//  Created by Dallas Johnson on 06/08/2020.
//  Copyright © 2020 Dallas Johnson. All rights reserved.
//

import SwiftUI

struct NavigationButton<CV: View, NV: View>: View {
    var contentView: CV
    @Binding var isPresented: Bool
    var navigationView: (Binding<Bool>) -> NV

    var body: some View {
        print("isPresented Nav Button: \(isPresented)")
        return Button(action: { self.isPresented = true }) {
            contentView.background(navigationView($isPresented))
        }
    }
}

struct NavigationButtonWithoutBinding<CV: View, NV: View>: View {
    var contentView: CV
    var navigationView: () -> NV
    var action: () -> ()

    var body: some View {
        return Button(action: action) {
            contentView.background(navigationView())
        }
    }
}

struct ModalLink<T: View>: View {
    var destination: T
    @Binding var isPresented: Bool

    var body: some View {
        EmptyView()
            .sheet(isPresented: $isPresented,
                   content: {
                    self.destination
            })
    }
}

struct NoLabelNavigationLink<D: View>: View {
    var destination: D
    @Binding var isPresented: Bool

    var body: some View {
        NavigationLink(destination: destination,
                       isActive: $isPresented) {
                        EmptyView()
        }
    }
}
