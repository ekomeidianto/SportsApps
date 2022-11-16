//
//  File.swift
//  
//
//  Created by Eko Meidianto on 14/11/22.
//

import Foundation
import Core

public struct Transformer: Mapper {
  public typealias Response = [TeamResponses.Teams]
  public typealias Domain = [TeamDomainModel]
  public typealias Entity = [TeamEntities]

  public init() {}

  public func transformTeamDomainToEntities(response: [TeamDomainModel]) -> [TeamEntities] {
    let team = [TeamEntities()]
    team[0].idTeam = response[0].teamId
    team[0].strDescriptionEN = response[0].teamDesc
    team[0].strTeam = response[0].teamName
    team[0].strTeamBadge = response[0].teamLogo
    return team
  }

  public func transformEntityToDomain(entity: [TeamEntities]) -> [TeamDomainModel] {
    return entity.map { result in
      return TeamDomainModel(
        teamId: result.idTeam,
        teamName: result.strTeam,
        teamLogo: result.strTeamBadge,
        teamDesc: result.strDescriptionEN
      )
    }
  }

  public func transformResponseToDomain(entity: [TeamResponses.Teams]) -> [TeamDomainModel] {
    return entity.map { result in
      return TeamDomainModel(
        teamId: result.idTeam ?? "",
        teamName: result.strTeam ?? "",
        teamLogo: result.strTeamBadge ?? "",
        teamDesc: result.strDescriptionEN ?? ""
      )
    }
  }
}
