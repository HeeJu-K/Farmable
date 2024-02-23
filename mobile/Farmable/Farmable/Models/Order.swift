//
//  Order.swift
//  Farmable
//
//  Created by HeeJu Kim on 2/23/24.
//

import Foundation

struct Order: Codable {
    let id: String
    let originFarm: String
    let destinationRestaurant: String
    let orderStatus: Int
    let quantity: Int
    let price: Int
    let timestamp: String
    let lastUpdateTime: String
}
