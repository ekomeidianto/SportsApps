//
//  File.swift
//  
//
//  Created by Eko Meidianto on 14/11/22.
//

import Core
import Combine

public struct TeamRepository
<LocaleDataSources: LocaleDataSource,
 RemoteDataSources: RemoteDataSource,
 Mappers: Mapper>: Repository where
LocaleDataSources.Response == TeamEntities,
LocaleDataSources.Request == TeamEntities,
RemoteDataSources.Response == [TeamResponses.Teams],
Mappers.Response == [TeamResponses.Teams],
Mappers.Domain == [TeamDomainModel],
Mappers.Entity == [TeamEntities] {
  public typealias Request = TeamEntities
  public typealias Response = [TeamDomainModel]

  private let _localeDataSource: LocaleDataSources
  private let _remoteDataSource: RemoteDataSources
  private let _mapper: Mappers

  public init(
    localeDataSource: LocaleDataSources,
    remoteDataSource: RemoteDataSources,
    mapper: Mappers
  ) {
    _localeDataSource = localeDataSource
    _remoteDataSource = remoteDataSource
    _mapper = mapper
  }

  public func getRemote() -> AnyPublisher<[TeamDomainModel], Error> {
    return self._remoteDataSource.get()
      .map { _mapper.transformResponseToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }

  public func getLocale() -> AnyPublisher<[TeamDomainModel], Error> {
    return self._localeDataSource.get()
      .map { _mapper.transformEntityToDomain(entity: $0) }
      .eraseToAnyPublisher()
  }

  public func addItem(request: TeamEntities) -> AnyPublisher<[TeamDomainModel], Error> {
    self._localeDataSource.add(entity: request)
      .filter { $0 }
      .flatMap { _ in
        self._localeDataSource.get()
          .map { _mapper.transformEntityToDomain(entity: $0) }
      }
      .eraseToAnyPublisher()
  }

  public func deleteItem(request: TeamEntities) -> AnyPublisher<[TeamDomainModel], Error> {
    self._localeDataSource.delete(entity: request)
      .filter { $0 }
      .flatMap { _ in
        self._localeDataSource.get()
          .map { _mapper.transformEntityToDomain(entity: $0) }
      }
      .eraseToAnyPublisher()
  }
}
