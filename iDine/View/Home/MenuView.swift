//
//  ContentView.swift
//  iDine
//
//  Created by Mahmoud Fouad on 4/12/21.
//

import SwiftUI

struct MenuView: View {
    
    private let menu = Bundle.main.decode(
        [MenuSection].self, from: "menu.json"
    )
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(menu) { section in
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
