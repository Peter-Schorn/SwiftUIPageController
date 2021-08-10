//
//  ContentView.swift
//  SwiftUIPageController
//
//  Created by Peter Schorn on 8/8/21.
//

import SwiftUI

struct ContentView: View {

    let totalPages = 3

    @State private var currentPage = 0

    var body: some View {
        VStack {
            
            Stepper(
                "\(currentPage + 1)",
                value: $currentPage,
                in: 0...(totalPages - 1)
            )
            .padding(.top, 5)
            
            PageView(
                pages: [
                    AnyView(page1),
                    AnyView(page2),
                    AnyView(page3)
                ],
                currentPage: $currentPage
            )
            
        }
    }
    
    var page1: some View {
        Color.red
            .overlay(
                Text("Page One")
                    .font(.largeTitle)
            )
    }
    
    var page2: some View {
        Color.blue
            .overlay(
                Text("Page Two")
                    .font(.largeTitle)
            )
    }
    
    var page3: some View {
        Color.orange
            .overlay(
                Text("Page Three")
                    .font(.largeTitle)
            )
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
