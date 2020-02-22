//
//  ContentView.swift
//  BetterRest
//
//  Created by Aaryan Kothari on 20/02/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeUpTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView{
            Form{
                VStack(alignment: .leading, spacing: CGFloat(0)){
                Text("When do you want to wake up")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                
                DatePicker("", selection: $wakeUp, displayedComponents: .hourAndMinute)
                .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                }
                Section {
                VStack(alignment: .leading, spacing: 0){
                Text("Desired amount of sleep")
                    .font(.headline)
                Stepper("\(sleepAmount, specifier: "%g") hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                }
                
                
                VStack(alignment: .leading, spacing: CGFloat(0)){
                Text("Daily cofee intake ")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Picker("Number of cups:",selection: $coffeeAmount) {
                    ForEach(1 ..< 13){
                        if($0 == 1) {
                            Text("1 cup")
                        } else {
                            Text("\($0) cups")
                        }
                    }
                }
                }
            }
        .navigationBarTitle("BetterRest")
        .navigationBarItems(trailing:
            Button(action: calculateBetTime){
                Text("Calculate")
            }
            
            )
                .alert(isPresented: $showingAlert){
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    static var defaultWakeUpTime : Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBetTime(){
       let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 3600
        let minutes = (components.minute ?? 0) * 60
        
        do {
           let prediction =  try model.prediction(wake: Double(hour + minutes), estimatedSleep: Double(sleepAmount), coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your Ideal Bedtime is.."
            
        } catch {
            alertTitle = "Error"
            alertMessage = "sorry, there was a problem calculating your bedtime"
            //something wentwrong
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
