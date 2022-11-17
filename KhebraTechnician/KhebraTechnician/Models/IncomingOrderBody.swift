//
//  IncomingOrderBody.swift
//  KhebraTechnician
//
//  Created by Sheheryar on 28/10/2022.
//

import Foundation

class IncomingOrderResponse: Codable {
    public var order: IncomingOrder?
    public var msg: String?
}

class IncomingOrder: Codable {
    var location: Location?
    var postpone: Bool?
    var appliedTechnician: [String]?
    var approve: Bool?
    var _id: String?
    var orderNumber: Int?
    var customer: Customer?
    var orderTime: OrderTime?
    var onDemant: Bool?
    var status, moreDetails: String?
    var url: String?
    var cash, assigned, isPaid: Bool?
    var address, service, serviceName: String?
    var totalPrice: Int?
    var couponCode,assignedTo: String?
    var reviewed: Bool?
    var createdAt, updatedAt: String?
    var v: Int?
    var paymentMethod: PaymentMethod?
    var scheduled: OrderTime?
    var createdAtTime: String?
}

class IncomingOrder2: Codable {
    var location: Location?
    var postpone: Bool?
    var appliedTechnician: [String]?
    var approve: Bool?
    var _id: String?
    var orderNumber: Int?
    var customer: String?
    var orderTime: OrderTime?
    var onDemant: Bool?
    var status, moreDetails: String?
    var url: String?
    var cash, assigned, isPaid: Bool?
    var address, service, serviceName: String?
    var totalPrice: Int?
    var couponCode,assignedTo: String?
    var reviewed: Bool?
    var createdAt, updatedAt: String?
    var v: Int?
    var paymentMethod: PaymentMethod?
    var scheduled: OrderTime?
    var createdAtTime: String?
}


class Customer: Codable {
    var location: Location?
    var id: String?
    var available, notificationAndOffer: Bool?
    var phone: String?
    var rating, numReviews: Int?
    var role: String?
    var otp, fullFilledOrders: Int?
    var favouriteTechnician, reviews: [String]?
    var createdAt, updatedAt, address, email: String?
    var name: String?
   // var ipInfo: IPInfo?
    var lastLocation: LastLocation?
    var balance: Int?

    
}

class LastLocation: Codable {
  //  var type: TypeEnum?
    var coordinates: [Double]?
    var id: String?
}
