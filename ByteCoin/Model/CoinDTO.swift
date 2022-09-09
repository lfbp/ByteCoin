//
//  CoinDTO.swift
//  ByteCoin
//
//  Created by lpereira on 09/09/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinDTO: Codable {
    let time, assetIDBase, assetIDQuote: String
    let rate: Double

    enum CodingKeys: String, CodingKey {
        case time
        case assetIDBase = "asset_id_base"
        case assetIDQuote = "asset_id_quote"
        case rate
    }
}
