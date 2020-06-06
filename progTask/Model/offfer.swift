//
//  offfer.swift
//  progTask
//
//  Created by Apple on 6/6/20.
//  Copyright © 2020 taj. All rights reserved.
//

import Foundation

struct Offer : Codable {
    
    let id : Int?
    let product_id : Int?
    let offer_price : Int?
    let start_at : String?
    let end_at : String?
    let created_at : String?
    let updated_at : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case product_id = "product_id"
        case offer_price = "offer_price"
        case start_at = "start_at"
        case end_at = "end_at"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        product_id = try values.decodeIfPresent(Int.self, forKey: .product_id)
        offer_price = try values.decodeIfPresent(Int.self, forKey: .offer_price)
        start_at = try values.decodeIfPresent(String.self, forKey: .start_at)
        end_at = try values.decodeIfPresent(String.self, forKey: .end_at)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }
    
    
}

