//
//  FakeItem.swift
//  UIBuildingTesting
//
//  Created by Ethan Smith on 21/10/21.
//

import Foundation
import SwiftUI

class FakeItem: Codable {
    var id: UUID
    var name: String
    var age: Int
    var heightCM: Int
    var skinColorStr: String
    
    init(identifier: UUID, name: String, age: Int, heightCM: Int, skinColorStr: String) {
        self.name = name
        self.age = age
        self.heightCM = heightCM
        self.skinColorStr = skinColorStr
        self.id = identifier
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case age
        case heightCM
        case skinColorStr
        case identifier
    }
    
    // Used for persistent storing of products to disk
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(heightCM, forKey: .heightCM)
        try container.encode(skinColorStr, forKey: .skinColorStr)
        try container.encode(id, forKey: .identifier)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        age = try values.decode(Int.self, forKey: .age)
        heightCM = try values.decode(Int.self, forKey: .heightCM)
        skinColorStr = try values.decode(String.self, forKey: .skinColorStr)
        id = try values.decode(UUID.self, forKey: .identifier)
    }
}

