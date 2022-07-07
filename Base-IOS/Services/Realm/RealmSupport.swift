//
//  RealmSupport.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 27/06/2022.
//

import Foundation
import RealmSwift

protocol RealmStoreable: Object, Copyable {}
protocol Copyable: Codable {}

extension Copyable {
    var copy: Self? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(Self.self, from: data)
    }
}

extension KeyedDecodingContainer where Key: CodingKey {
    func defaultDecode<T: Decodable & ObjectCDefaultValue>(forKey key: Key) -> T {
        return self.optionalDecode(forKey: key) ?? T.default
    }
    
    func optionalDecode<T: Decodable>(forKey key: Key) -> T? {
        do {
            return try self.decodeIfPresent(T.self, forKey: key)
        } catch {
            print(error)
            return nil
        }
    }
    
    func decode<T: Decodable>(forKey key: Key) throws -> T {
        return try self.decode(T.self, forKey: key)
    }
}

protocol ObjectCDefaultValue {
    static var `default`: Self { get }
}

extension Int: ObjectCDefaultValue {
    static var `default`: Int { 0 }
}

extension String: ObjectCDefaultValue {
    static var `default`: String { "" }
}

extension Bool: ObjectCDefaultValue {
    static var `default`: Bool { false }
}
