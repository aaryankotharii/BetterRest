//
//  ContentView.swift
//  BetterRest
//
//  Created by Aaryan Kothari on 20/02/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date()
    @State  var stepperValue = 10.0
    var body: some View {
        DatePicker(selection: $wakeUp,displayedComponents: .hourAndMinute, label: { Text("Date") })
        .labelsHidden()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
