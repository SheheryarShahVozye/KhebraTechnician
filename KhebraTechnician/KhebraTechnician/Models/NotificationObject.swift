//
//  NotificationObject.swift
//  KhebraTechnician
//
//  Created by apple on 13/11/2022.
//

import Foundation

class NotificationObjectElement: Codable {
    var id, title, descripton, user: String?
    var orderId: IncomingOrder?
    var v: Int?
    var createdAt: String?
    var updatedAt: String?

  
}
