//
//  RealmManager.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 27/06/2022.
//

import UIKit
import RealmSwift

extension RealmStoreable {
    @discardableResult
    func save() -> Bool {
        guard let store = self.copy else { return false }
        return RealmManager.shared.save(store)
    }
    
    @discardableResult
    func delete() -> Bool {
        guard let realmObject = self.realmObject else { return false }
        return RealmManager.shared.delete(realmObject)
    }
    /// need set primaryKey for Object
    public static func from(_ primiriKey: Any?) -> Self? {
        guard let key = Self.primaryKey() else { return nil }
        guard var value = primiriKey else { return nil }
        if let string = value as? String {
            value = "'\(string)'"
        }
        guard let object = RealmManager.shared.objects(Self.self, filters: [key: ("=", value)]).first else { return nil }
        return object.copy
    }
    
    static func getFromDatabase(_ predicate: String? = nil, sort key: String? = nil, ascending: Bool = true) -> [Self] {
        let objects = RealmManager.shared.objects(Self.self, predicateStr: predicate, sort: key, ascending: ascending)
        return objects.compactMap({ $0.copy })
    }
    
    fileprivate var realmObject: RealmStoreable? {
        guard let key = Self.primaryKey() else { return nil }
        guard let valueKey = self.value(forKey: key) else { return nil }
        var compare = "\(valueKey)"
        if let stringKey = valueKey as? String { compare = "'\(stringKey)'" }
        return RealmManager.shared.objects(Self.self, predicateStr: "\(key) == \(compare)").first
    }
}

extension Array where Element: RealmStoreable {
    @discardableResult
    func save() -> Bool {
        let obj = self.compactMap ( {$0.copy})
        return RealmManager.shared.save(obj)
    }
    
    @discardableResult
    func delete() -> Bool {
        let objects = self.compactMap({ $0.realmObject })
        return RealmManager.shared.delete(objects)
    }
}

enum RealmRelationType: String {
    case and = "AND"
    case or = "OR"
}

final class RealmManager {
    private(set) var realm: Realm!
    static var shared: RealmManager {
        if Thread.isMainThread {
            return mainInstance
        } else {
            return RealmManager()
        }
    }
    /// for main thread
    private static let mainInstance = RealmManager()
    /// for not main thread
    private init() {
        let defaultRealmConfig = Realm.Configuration(
            schemaVersion: 0,
            migrationBlock: {[weak self] (_, oldSchemaVersion) in
                self?.migration(with: oldSchemaVersion)
        })

        Realm.Configuration.defaultConfiguration = defaultRealmConfig
        do {
            self.realm = try Realm(configuration: defaultRealmConfig)
        } catch {
            if let fileURL = defaultRealmConfig.fileURL {
                try? FileManager.default.removeItem(at: fileURL)
                self.realm = try? Realm(configuration: defaultRealmConfig)
            }
        }

        print("Realm Database: \(self.realm.configuration.fileURL?.absoluteString ?? "")")
    }

    func configuration() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 0,
            migrationBlock: { migration, oldSchemaVersion in

        })
    }

    func clearRealm() {
        try? realm.write {
            self.realm.deleteAll()
        }
    }

    //MARK: Base function
    @discardableResult
    func save<S>(_ objects : S) -> Bool where S : Sequence, S.Element : RealmSwift.Object {
        do {
            try realm.write {
                self.realm.add(objects, update: .modified)
            }
            return true
        } catch {
            return false
        }
    }

    // Get list objects from Realm
    // @param type is type of class
    // @param filters contains key, value. Key is field name, value is Tuple(String, Any).
    // This tuple contains operation for the filter, and Any is value
    // Exp: "name = 'Tony' AND age > 25"
    func objects<T: Object>(_ type: T.Type, filters: [String: (String, Any)], relation: RealmRelationType = .and) -> [T] {
        var conditions: [String] = []
        for (key, value) in filters {
            if value.1 is String {
                conditions.append("\(key) \(value.0) '\(value.1)'")
            } else {
                conditions.append("\(key) \(value.0) \(value.1)")
            }
        }
        let predicateStr = conditions.joined(separator: " \(relation.rawValue) ")
        let predicate = NSPredicate(format: predicateStr)
        let objects = realm.objects(type).filter(predicate)
        return Array(objects)
    }

    // @param predicateStr is string for condition where
    // Exp: "name = 'Tony' AND age > 25 OR gender = 'male'"
    func objects<T: Object>(_ type: T.Type, predicateStr: String? = nil, sort key: String? = nil, ascending: Bool = true) -> [T] {
        var objects = realm.objects(type)
        if let predicateStr = predicateStr, !predicateStr.isEmpty {
            let predicate = NSPredicate(format: predicateStr)
            objects = objects.filter(predicate)
        }
        if let sort = key, !sort.isEmpty {
            objects = objects.sorted(byKeyPath: sort, ascending: ascending)
        }
        return Array(objects)
    }

    @discardableResult
    func delete<S>(_ objects : S) -> Bool where S : Sequence, S.Element : RealmSwift.Object {
        do {
            try realm.write {
                self.realm.delete(objects)
            }
            return true
        } catch{
            return false
        }
    }
    
    @discardableResult
    func save(_ object : Object) -> Bool {
        do {
            try realm.write {
                self.realm.add(object, update: .modified)
            }
            return true
        } catch{
            return false
        }
    }

    @discardableResult
    func delete(_ object : Object) -> Bool {
        do {
            try realm.write {
                self.realm.delete(object)
            }
            return true
        } catch{
            return false
        }
    }
}

extension RealmManager {
    /// migration func
    private func migration(with oldVersion: UInt64) {
        if oldVersion == 0 {
            // Migrate from v0 to v1
            print("setup for version 1")
        }
    }
}
