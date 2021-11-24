//
//  ContentView.swift
//  SwiftUIcarousel
//
//  Created by Eugene Berezin on 11/8/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedItem = 0
    @EnvironmentObject private var viewModel: ViewModel
    let tabBarImages = ["house", "play.circle.fill", "bookmark.fill", "person.fill"]
   
    
    var body: some View {
        VStack {
            ZStack {
                switch selectedItem {
                case 0:
                    HomeView()
                default:
                    Text("View has not been implemented")
                        .foregroundColor(.white)
                }
            }
            Spacer()
            if viewModel.isTabBarDisplayed {
                HStack {
                    ForEach(tabBarImages.indices) { index in
                       Spacer()
                        Button {
                           selectedItem = index
                        } label: {
                            Image(systemName: tabBarImages[index])
                                .tint(.white)
                        }
                        Spacer()

                    }
                }
                .padding()
                .background {
                    Color("backGround")
                       
                }
                .cornerRadius(8)
                .padding()
            }
        }
        .background {
            Color.black
                .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
