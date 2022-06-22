//
//  SearchView.swift
//  test
//
//  Created by Muhammad Zahid Imran on 25/03/2022.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    @State var isEditing: Bool = false
    @State var isShowingDetailView = false
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search", text: $viewModel.searchQuery)
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                                
                                if isEditing {
                                    Button(action: {
                                        viewModel.searchQuery = ""
                                    }) {
                                        Image(systemName: "multiply.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    }
                                }
                            }
                        )
                        .padding(.horizontal, 10)
                        .onChange(of: viewModel.searchQuery) { newValue in
                            withAnimation {
                                self.isEditing = newValue.count > 0
                            }
                        }
                    
                    if isEditing {
                        Button(action: {
                            viewModel.refresh()
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }) {
                            Text("Submit")
                        }
                        .padding(.trailing, 10)
                        .transition(.move(edge: .trailing))
                    }
                }
                .padding(.vertical)
                Spacer()
                SearchResultView()
            }
            .navigationTitle("Search User")
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
