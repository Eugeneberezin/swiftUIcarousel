//
//  SearchBarView.swift
//  SwiftUIcarousel
//
//  Created by Eugene Berezin on 11/23/21.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    @State private var isEditing = false
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .submitLabel(.search)
                .foregroundColor(.gray)
                .padding(7)
                .padding(.horizontal, 10)
                .padding(5)
                .background(Color("backGround"))
                .cornerRadius(8)
                .onSubmit {
                    viewModel.isTabBarDisplayed = true
                }
                .overlay {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity,  alignment: .trailing)
                            .padding(.trailing, 8)
                        
                        if isEditing {
                            Button {
                                text = "Search..."
                                viewModel.isTabBarDisplayed = true
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }

                        }
                    }
                }
                .padding(.horizontal, 10)
                .onTapGesture {
                    viewModel.loadingStatus = LoadStatus.ready(nextPage: 1)
                    viewModel.movies = []
                    isEditing = true
                    text = ""
                    viewModel.isTabBarDisplayed = false
                }
            if isEditing {
                Button {
                    isEditing = false
                    text = "Search..."
                    viewModel.isTabBarDisplayed = true
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.easeOut, value: 0.1)

            }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
