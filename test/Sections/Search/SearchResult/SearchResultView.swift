//
//  SearchView.swift
//  test
//
//  Created by Muhammad Zahid Imran on 23/03/2022.
//

import SwiftUI

struct SearchResultView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach (viewModel.response.items) { item in
                    SearchResultRowView(user: item)
                        .frame(height: 87)
                        .onAppear {
                            if viewModel.response.items.last == item {
                                viewModel.loadNextPageIfPossible()
                            }
                        }
                    Divider()
                }
                
                if viewModel.state == .loading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if case .error(_) = viewModel.state {
                    Button {
                        viewModel.loadNextPageIfPossible()
                    } label: {
                        Text("Retry")
                            .padding()
                    }

                }
            }
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView()
    }
}
