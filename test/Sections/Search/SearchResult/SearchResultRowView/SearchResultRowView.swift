//
//  SearchResultRowView.swift
//  test
//
//  Created by Muhammad Zahid Imran on 24/03/2022.
//

import SwiftUI
import Kingfisher

struct SearchResultRowView: View {
    let user: User
    var body: some View {
        GeometryReader { proxy in
            HStack {
                KFImage(URL(string: user.avatarURL ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.height, height: proxy.size.height, alignment: .center)
                VStack(alignment: .leading) {
                    Text(user.login ?? "")
                    Text(user.type?.rawValue ?? "" )
                }
            }
        }
    }
}
