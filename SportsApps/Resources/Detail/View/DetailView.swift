//
//  DetailView.swift
//  SportsApps
//
//  Created by Eko Meidianto on 19/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
  @StateObject var detailPresenter: DetailPresenter

  init(detailPresenter: DetailPresenter) {
    _detailPresenter = StateObject(wrappedValue: detailPresenter)
  }

  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      imageView
      description
    }
    .frame(width: UIScreen.main.bounds.width - 30)
    .navigationTitle(detailPresenter.teams.teamName)
    .navigationBarTitleDisplayMode(.inline)
    .onAppear(perform: {
      self.detailPresenter.getTeamsFavorite()
    })
    .toolbar {
      Button {
        if detailPresenter.isFavorite {
          detailPresenter.deleteFromFavorite()
        } else {
          detailPresenter.addToFavorite()
        }
      } label: {
        if detailPresenter.isFavorite {
          Image(systemName: "heart.fill")
            .foregroundColor(Color.red)
        } else {
          Image(systemName: "heart")
            .foregroundColor(.black)
            .bold()
        }
      }
    }
  }

  var imageView: some View {
    WebImage(url: URL(string: detailPresenter.teams.teamLogo))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFit()
      .frame(width: 250.0, height: 250.0, alignment: .center)
  }

  var description: some View {
    VStack(alignment: .leading) {
      Text("Description")
        .font(.title2)
        .bold()
        .padding(.vertical)

      Text(detailPresenter.teams.teamDesc)
        .font(.system(size: 15))
    }
  }
}
