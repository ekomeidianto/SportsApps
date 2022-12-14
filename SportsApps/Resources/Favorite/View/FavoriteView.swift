//
//  FavoriteView.swift
//  SportsApps
//
//  Created by Eko Meidianto on 19/10/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Team

struct FavoriteView: View {
  @ObservedObject var favoritePresenter: GetListPresenter<
    TeamEntities,
    TeamDomainModel,
    Interactor<TeamEntities, [TeamDomainModel], TeamRepository<
      TeamLocaleDataSource,
      TeamRemoteDataSource,
      Transformer>>>

  var body: some View {
    VStack {
      if favoritePresenter.isLoading {
        ProgressView()
      } else if favoritePresenter.list.isEmpty {
        Text("There aren't Favorite Teams")
          .font(.title3)
          .bold()
          .foregroundColor(.black)
      } else if favoritePresenter.isError {
        EmptyView()
      } else {
        ScrollView(.vertical, showsIndicators: false) {
          ForEach(favoritePresenter.list) { team in
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
    .onAppear(perform: {
      favoritePresenter.getListLocale(request: nil)
    })
    .navigationTitle("Favorite Teams")
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

  private func navigateToDetail<Content: View>(
    for team: TeamDomainModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: FavoriteRouter().goToDetailView(for: team)) {
      content()
    }
  }
}
