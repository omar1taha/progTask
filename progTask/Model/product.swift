//
//  product.swift
//  progTask
//
//  Created by Apple on 6/6/20.
//  Copyright © 2020 taj. All rights reserved.
//

import Foundation


struct product : Codable {
    let id : Int?
    let brand_id : Int?
    let category_id : Int?
    let name_ar : String?
    let name_en : String?
    let size : String?
    let unit_ar : String?
    let unit_en : String?
    let description_ar : String?
    let description_en : String?
    let image : String?
    let price : Double?
    let active : Int?
    let created_at : String?
    let updated_at : String?
    let name : String?
    let description : String?
    let image_url : [String]?
    let offer : Offer?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case brand_id = "brand_id"
        case category_id = "category_id"
        case name_ar = "name_ar"
        case name_en = "name_en"
        case size = "size"
        case unit_ar = "unit_ar"
        case unit_en = "unit_en"
        case description_ar = "description_ar"
        case description_en = "description_en"
        case image = "image"
        case price = "price"
        case active = "active"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case name = "name"
        case description = "description"
        case image_url = "image_url"
        case offer = "offer"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        brand_id = try values.decodeIfPresent(Int.self, forKey: .brand_id)
        category_id = try values.decodeIfPresent(Int.self, forKey: .category_id)
        name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
        name_en = try values.decodeIfPresent(String.self, forKey: .name_en)
        size = try values.decodeIfPresent(String.self, forKey: .size)
        unit_ar = try values.decodeIfPresent(String.self, forKey: .unit_ar)
        unit_en = try values.decodeIfPresent(String.self, forKey: .unit_en)
        description_ar = try values.decodeIfPresent(String.self, forKey: .description_ar)
        description_en = try values.decodeIfPresent(String.self, forKey: .description_en)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        active = try values.decodeIfPresent(Int.self, forKey: .active)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        image_url = try values.decodeIfPresent([String].self, forKey: .image_url)
        offer = try values.decodeIfPresent(Offer.self, forKey: .offer)
    }
    
}
