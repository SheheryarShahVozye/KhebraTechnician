//
//  AssignedOrdersClass.swift
//  KhebraTechnician
//
//  Created by apple on 13/11/2022.
//

import Foundation

class AssignedOrderObjectElement: Codable {
    public var scheduled: OrderTime?
    public var location: Location?
    public var _id: String?
    public var postpone: Bool?
    public var appliedTechnician: [String]?
    public var orderNumber: Int?
    public var customer: Customer?
    public var createdAtTime, status, moreDetails: String?
    public var url: [String]?
    public var approve, cash, assigned, isPaid: Bool?
    public var address, service, serviceName: String?
    public var totalPrice: Int?
    public var couponCode, createdAt, updatedAt: String?
    public var __v: Int?
    public var assignedTo: TechnicianProfile?
    public var technicianStatus: [TechnicianStatus]?
    public var invoice: Invoice?
    public var moyasarPaymentID: String?
}

class updatedStatusResponse: Codable {
    var order: AssignedOrderObjectElement?
    var msg: String?
}

class Invoice: Codable {
    var order: String?
    var taxNumber, technicianFare, spareParts, workFee: Int?
    var sparePartDelivery, totalPrice: Int?
    var _id, createdAt, updatedAt: String?
}
