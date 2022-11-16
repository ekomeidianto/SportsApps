//
//  HomeView.swift
//  SportsApps
//
//  Created by Eko Meidianto on 18/10/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Team

struct HomeView: View {
  @ObservedObject var homePresenter: GetListPresenter<
    TeamEntities,
    TeamDomainModel,
    Interactor<TeamEntities, [TeamDomainModel], TeamRepository<
      TeamLocaleDataSource,
      TeamRemoteDataSource,
      Transformer>>>

  var body: some View {
    VStack {
      if homePresenter.isLoading {
        ProgressView()
      } else if homePresenter.isError {
        EmptyView()
      } else if homePresenter.list.isEmpty { // 1
        EmptyView()
      } else {
        content
      }
    }
    .onAppear(perform: {
      if self.homePresenter.list.count == 0 {
        self.homePresenter.getListRemote(request: nil)
      }
    })
    .navigationTitle("Sports Apps")
    .toolbar {
      ToolbarItemGroup(placement: .navigationBarTrailing) {
        navigateToFavorite {
          Image(systemName: "heart.fill")
            .foregroundColor(Color.red)
        }

        navigateToProfile {
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

  private func desc(item: TeamDomainModel) -> some View {
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

  var content: some View {
    ScrollView(.vertical, showsIndicators: false) {
      ForEach(homePresenter.list) { team in
        ZStack {
          navigateToDetail(for: team) {
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

  func navigateToDetail<Content: View>(
    for team: TeamDomainModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: HomeRouter().goToDetailView(for: team)) {
      content()
    }
  }

  func navigateToFavorite<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    NavigationLink(destination: HomeRouter().goToFavorite) {
      content()
    }
  }

  func navigateToProfile<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    NavigationLink(destination: HomeRouter().goToProfile) {
      content()
    }
  }
}
