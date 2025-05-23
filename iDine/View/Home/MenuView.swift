//
//  ContentView.swift
//  iDine
//
//  Created by Mahmoud Fouad on 4/12/21.
//

import SwiftUI

struct MenuView: View {
    
    @StateObject private var menuHandler = MenuHandler()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(menuHandler.menu) { section in
                    Section(header: Text(section.name)) {
                        ForEach(section.items) { item in
                            NavigationLink(
                                destination: ItemDetail(item: item)
                            ){ ItemRow(item: item) }
                        }
                    }
                }
            }
            .navigationTitle("Menu")
            .listStyle(GroupedListStyle())
            .task {
                do {
                    try await menuHandler.loadMenu()
                } catch {
                    print(error.localizedDescription)
                }
               
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
