//
//  RemoteDataSource.swift
//  SportsApps
//
//  Created by Eko Meidianto on 18/10/22.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {
  func getTeams() -> AnyPublisher<[TeamResponse.Teams], Error>
}

final class RemoteDataSource: NSObject {
  private override init() { }
  static let sharedInstance: RemoteDataSource =  RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  func getTeams() -> AnyPublisher<[TeamResponse.Teams], Error> {
    return Future<[TeamResponse.Teams], Error> { completion in
      if let url = URL(string: Methods.Get.getTeam.url) {
        AF.request(url)
          .validate()
          .responseDecodable(of: TeamResponse.self) { response in
            switch response.result {
              case .success(let value):
                completion(.success(value.teams))
              case .failure:
                completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
