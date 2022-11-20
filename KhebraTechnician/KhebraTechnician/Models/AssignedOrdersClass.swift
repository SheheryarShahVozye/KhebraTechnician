//
//  AssignedOrdersClass.swift
//  KhebraTechnician
//
//  Created by apple on 13/11/2022.
//

import Foundation

class AssignedOrderObjectElement: Codable {
    var scheduled: OrderTime?
    var location: Location?
    var _id: String?
    var postpone: Bool?
    var appliedTechnician: [String]?
    var orderNumber: Int?
    var customer: Customer?
    var createdAtTime, status, moreDetails: String?
    var url: String?
    var approve, cash, assigned, isPaid: Bool?
    var address, service, serviceName: String?
    var totalPrice: Int?
    var couponCode, createdAt, updatedAt: String?
    var __v: Int?
    var assignedTo: TechnicianProfile?
}
