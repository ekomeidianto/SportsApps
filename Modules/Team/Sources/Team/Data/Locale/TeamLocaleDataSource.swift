//
//  File.swift
//  
//
//  Created by Eko Meidianto on 14/11/22.
//

import Foundation
import Core
import Combine
import RealmSwift

public struct TeamLocaleDataSource: LocaleDataSource {
  public typealias Request = TeamEntities
  public typealias Response = TeamEntities

  private let _realm: Realm

  public init(realm: Realm) {
    _realm = realm
  }

  public func get() -> AnyPublisher<[TeamEntities], Error> {
    return Future<[TeamEntities], Error> { completion in
      let teams: Results<TeamEntities> = {
        _realm.objects(TeamEntities.self)
          .sorted(byKeyPath: "strTeam", ascending: true)
      }()
      completion(.success(teams.toArray(ofType: TeamEntities.self)))
    }.eraseToAnyPublisher()
  }

  public func add(entity: TeamEntities) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm.write {
          _realm.add(entity, update: .all)
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }

  public func delete(entity: TeamEntities) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      let predicate = NSPredicate(format: "idTeam == %@", entity.idTeam)
      let targetDelete = _realm.objects(TeamEntities.self).filter(predicate).first
      do {
        try _realm.write {
          _realm.delete(targetDelete!)
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }
}
