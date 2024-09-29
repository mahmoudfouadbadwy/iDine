//
//  iDineApp.swift
//  iDine
//
//  Created by Mahmoud Fouad on 4/12/21.
//

import SwiftUI

@main
struct iDineApp: App {
    let order = Order()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order)
        }
    }
}
