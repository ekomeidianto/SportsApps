//
//  HomeView.swift
//  SportsApps
//
//  Created by Eko Meidianto on 18/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
  @StateObject var homePresenter: HomePresenter

  init(homePresenter: HomePresenter) {
    _homePresenter = StateObject(wrappedValue: homePresenter)
  }

  var body: some View {
    VStack {
      if homePresenter.isLoading {
        ProgressView()
      } else {
        ScrollView(.vertical, showsIndicators: false) {
          ForEach(homePresenter.teams) { team in
            homePresenter.navigateToDetail(for: team) {
              VStack(spacing: 15) {
                imageView(image: team.teamLogo)
                desc(item: team)
              }
              .frame(width: UIScreen.main.bounds.width - 35, height: 250)
              .background(Color.random.opacity(0.3))
              .cornerRadius(35)
            }
          }
        }
      }
    }
    .onAppear(perform: {
      if self.homePresenter.teams.count == 0 {
        self.homePresenter.getTeams()
      }
    })
    .navigationTitle("Sports Apps")
    .toolbar {
      ToolbarItemGroup(placement: .navigationBarTrailing) {
        homePresenter.navigateToFavorite {
          Image(systemName: "heart.fill")
            .foregroundColor(Color.red)
        }

        homePresenter.navigateToProfile {
          Image(systemName: "person")
            .bold()
            .foregroundColor(Color.black)
        }
      }
    }
  }

  private func imageView(image: String) -> some View {
    WebImage(url: URL(string: image))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFit()
      .frame(width: 200)
      .cornerRadius(25)
      .padding(.top)
  }

  private func desc(item: TeamModel) -> some View {
    VStack(alignment: .leading) {
      Text(item.teamName)
        .font(.title)
        .bold()
        .foregroundColor(Color.black)

      Text(item.teamDesc)
        .font(.system(size: 15))
        .lineLimit(2)
        .foregroundColor(Color.black)
        .multilineTextAlignment(.leading)
    }
    .padding(
      EdgeInsets(
        top: 0,
        leading: 15,
        bottom: 15,
        trailing: 15
      )
    )
  }
}
