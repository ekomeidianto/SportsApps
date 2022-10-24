//
//  TeamMapper.swift
//  SportsApps
//
//  Created by Eko Meidianto on 18/10/22.
//

import Foundation

final class TeamMapper {
  static func mapTeamDomainToEntities(
    input teamResponses: TeamModel
  ) -> TeamEntity {
//    return teamResponses.map { result in
      let team = TeamEntity()
      team.idTeam = teamResponses.teamId
      team.strDescriptionEN = teamResponses.teamDesc
      team.strTeam = teamResponses.teamName
      team.strTeamBadge = teamResponses.teamLogo
      return team
//    }
  }

  static func mapTeamEntitiesToDomains(
    input teamEntities: [TeamEntity]
  ) -> [TeamModel] {
    return teamEntities.map { result in
      return TeamModel(
        teamId: result.idTeam,
        teamName: result.strTeam,
        teamLogo: result.strTeamBadge,
        teamDesc: result.strDescriptionEN
      )
    }
  }

  static func mapTeamResponsesToDomains(
    input teamResponses: [TeamResponse.Teams]
  ) -> [TeamModel] {
    return teamResponses.map { result in
      return TeamModel(
        teamId: result.idTeam ?? "",
        teamName: result.strTeam ?? "",
        teamLogo: result.strTeamBadge ?? "",
        teamDesc: result.strDescriptionEN ?? ""
      )
    }
  }
}
