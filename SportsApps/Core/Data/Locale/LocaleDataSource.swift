//
//  LocaleDataSource.swift
//  SportsApps
//
//  Created by Eko Meidianto on 18/10/22.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: AnyObject {
  func getTeams() -> AnyPublisher<[TeamEntity], Error>
  func addTeams(from teams: TeamEntity) -> AnyPublisher<Bool, Error>
  func deleteTeams(from teams: TeamEntity) -> AnyPublisher<Bool, Error>
}

final class LocaleDataSource: NSObject {
  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
  func getTeams() -> AnyPublisher<[TeamEntity], Error> {
    return Future<[TeamEntity], Error> { completion in
      if let realm = self.realm {
        let teams: Results<TeamEntity> = {
          realm.objects(TeamEntity.self)
            .sorted(byKeyPath: "strTeam", ascending: true)
        }()
        completion(.success(teams.toArray(ofType: TeamEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidDatabase))
      }
    }.eraseToAnyPublisher()
  }

  func addTeams(from teams: TeamEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            realm.add(teams, update: .all)
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidDatabase))
      }
    }.eraseToAnyPublisher()
  }

  func deleteTeams(from teams: TeamEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        let predicate = NSPredicate(format: "idTeam == %@", teams.idTeam)
        let targetDelete = realm.objects(TeamEntity.self).filter(predicate).first
        do {
          try realm.write {
            realm.delete(targetDelete!)
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidDatabase))
      }
    }.eraseToAnyPublisher()
  }

}

extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}
