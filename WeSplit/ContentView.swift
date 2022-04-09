//
//  ContentView.swift
//  WeSplit
//
//  Created by Emmanuel K. Nketia on 4/6/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = Array(0...100)
    let numberOfPeoples = Array(2...100)
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalLessTip: Double {
        
        let peopleCount = Double(numberOfPeople + 2)
        
        let totalLessTip = checkAmount/peopleCount
        
        return totalLessTip
    }
    
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField ("Amount", value: $checkAmount, format:
                            .currency(code: Locale.current.currencyCode ?? "GH¢"))
                    .keyboardType(.numberPad)
                    .focused($amountIsFocused)
                    
                    Picker ("Number of People",selection: $numberOfPeople) {
                        ForEach(numberOfPeoples, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                }
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("How much Tip do you want to add?")
                }
                Section{
                    Text ( totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "GH¢"))
                } header: {
                    Text("Amount Per Person")
                }
                Section{
                    Text( totalLessTip , format: .currency(code: Locale.current.currencyCode ?? "GH¢"))
                } header: {
                    Text("Amount Per Person without Tip")
                }
            } .navigationTitle("WeSplit")
            
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
