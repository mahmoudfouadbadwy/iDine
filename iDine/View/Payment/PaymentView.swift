//
//  PaymentView.swift
//  iDine
//
//  Created by Mahmoud Fouad on 4/17/21.
//

import SwiftUI

struct PaymentView: View {
 
    @EnvironmentObject var order: Order
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tip = 15
    @State private var showingPaymentAlert = false
    
    private let paymentTypes = ["Cash", "Credit card", "iDine "]
    private let tipsAmount = [0, 10, 15, 20, 25]
    private var totalPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let total = Double(order.total)
        let tipValue =  (total  * Double(tip)) / 100
        return formatter.string(from: NSNumber(value: total + tipValue)) ?? "0.0$"
    }
    
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: $paymentType) {
                    ForEach(paymentTypes, id: \.self) {
                        Text($0)
                    }
                }
                
                Toggle("Add iDine loyalty card", isOn: $addLoyaltyDetails)
                
                if addLoyaltyDetails {
                    TextField("Enter your iDine ID",
                              text: $loyaltyNumber
                                .animation())
                }
            }
            
            Section(header: Text("Add a tip?")) {
                Picker("Percentage", selection: $tip) {
                    ForEach(tipsAmount, id: \.self) {
                        Text("\($0)%")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header:
                        Text("TOTAL: \(totalPrice)")
                        .font(.largeTitle)
            ) {
                Button("Confirm order") {
                    showingPaymentAlert.toggle()
                }
            }
            
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingPaymentAlert) {
            Alert(title: Text("Order Confirmed"),
                  message: Text("Total Price is \(totalPrice)"),
                  dismissButton: .default(Text("Ok")))
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
            .environmentObject(Order())
    }
}
