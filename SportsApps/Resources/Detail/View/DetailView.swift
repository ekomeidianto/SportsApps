//
//  DetailView.swift
//  SportsApps
//
//  Created by Eko Meidianto on 19/10/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Team
import Core

struct DetailView: View {
  @ObservedObject var detailPresenter: DetailsPresenter<
    TeamEntities,
    TeamDomainModel,
    Interactor<
      TeamEntities,
      [TeamDomainModel],
      TeamRepository<TeamLocaleDataSource, TeamRemoteDataSource, Transformer>>>

  var teams: TeamDomainModel

  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      imageView
      description
    }
    .frame(width: UIScreen.main.bounds.width - 30)
    .navigationTitle(teams.teamName)
    .navigationBarTitleDisplayMode(.inline)
    .onAppear(perform: {
      detailPresenter.getListLocale {
        if !detailPresenter.list.isEmpty {
          if detailPresenter.list.contains(where: { $0.teamName == teams.teamName }) {
            detailPresenter.isFavorite = true
          } else {
            detailPresenter.isFavorite = false
          }
        }
      }
    })
    .toolbar {
      Button {
        if detailPresenter.isFavorite {
          detailPresenter.deleteFromFavorite(request: Transformer().transformTeamDomainToEntities(response: [teams])[0])
        } else {
          detailPresenter.addToFavorite(request: Transformer().transformTeamDomainToEntities(response: [teams])[0])
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
    WebImage(url: URL(string: detailPresenter.team.teamLogo))
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

      Text(detailPresenter.team.teamDesc)
        .font(.system(size: 15))
    }
  }
}
