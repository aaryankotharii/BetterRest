//
//  ContentView.swift
//  BetterRest
//
//  Created by Aaryan Kothari on 20/02/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State  var stepperValue = 10.0
    var body: some View {
        Stepper("yo \(stepperValue, specifier: "%g")", value: $stepperValue, in: 4...12, step: 0.25)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
