//
//  productResponse.swift
//  progTask
//
//  Created by Apple on 6/6/20.
//  Copyright © 2020 taj. All rights reserved.
//

import Foundation
struct productResponse : Codable {
    let message : String?
    let data : Dataproduct?
    
    enum CodingKeys: String, CodingKey {
        
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(Dataproduct.self, forKey: .data)
    }
    
}
