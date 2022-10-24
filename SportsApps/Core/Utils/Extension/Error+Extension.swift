//
//  Error+Extension.swift
//  SportsApps
//
//  Created by Eko Meidianto on 18/10/22.
//

import Foundation

enum URLError: LocalizedError {
  case invalidResponse
  case urlUnreachable(URL)

  var errorDescription: String? {
    switch self {
      case .invalidResponse: return "The server responded with garbage."
      case .urlUnreachable(let url): return "\(url.absoluteString) is unreachable."
    }
  }
}

enum DatabaseError: LocalizedError {
  case invalidDatabase
  case requestFailed

  var errorDescription: String? {
    switch self {
    case .invalidDatabase: return "Database can't access."
    case .requestFailed: return "Your request failed."
    }
  }
}
