//
//  File.swift
//  
//
//  Created by Eko Meidianto on 14/11/22.
//

import Core
import Combine
import Alamofire
import Foundation

public struct TeamRemoteDataSource: RemoteDataSource {
  public typealias Request = Any
  public typealias Response = [TeamResponses.Teams]

  private let _endpoint: String

  public init(endpoint: String) {
    _endpoint = endpoint
  }

  public func get() -> AnyPublisher<[TeamResponses.Teams], Error> {
    return Future<[TeamResponses.Teams], Error> { completion in
      if let url = URL(string: _endpoint) {
        AF.request(url)
          .validate()
          .responseDecodable(of: TeamResponses.self) { response in
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
