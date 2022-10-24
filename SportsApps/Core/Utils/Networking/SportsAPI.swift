//
//  SportsAPI.swift
//  SportsApps
//
//  Created by Eko Meidianto on 18/10/22.
//

import Foundation

struct API {
  static let baseUrl = "https://www.thesportsdb.com/api/v1/json/2/"
}

protocol Method {
  var url: String { get }
}

enum Methods {
  enum Get: Method {
    case getTeam
    case getEquipment

    public var url: String {
      switch self {
        case .getTeam: return "\(API.baseUrl)search_all_teams.php?l=English%20Premier%20League"
        case .getEquipment: return "\(API.baseUrl)filter.php?c="
      }
    }
  }
}
