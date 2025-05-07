//
//  Resort.swift
//  SnowSeeker
//
//  Created by Rob Ranf on 5/6/25.
//

import Foundation

struct Resort: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var country: String
    var description: String
    var imageCredit: String
    var price: Int
    var size: Int
    var snowDepth: Int
    var elevation: Int
    var runs: Int
    var facilities: [String]
    
    // When static let is used for properties, Swift automatically makes
    // them lazy, they don't get created until they are used. What this means
    // in this case is that when we try to read Resord.example, Swift will
    // create Resort.allResorts first, then send back the first item in that
    // array for Resort.example. This means we can always be sure the two
    // properties will be run in the correct order, there's no chance of example
    // going missing because allResorts wasn't called yet.
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}
