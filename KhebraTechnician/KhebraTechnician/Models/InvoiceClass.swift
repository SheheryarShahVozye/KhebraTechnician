//
//  InvoiceClass.swift
//  KhebraTechnician
//
//  Created by apple on 20/11/2022.
//

import Foundation

class InvoiceObject: Codable {
    var order: String?
     var taxNumber, technicianFare, spareParts, workFee: Int?
     var sparePartDelivery, totalPrice: Int?
     var  id, createdAt, updatedAt: String?
    var url : [String]?
}


class TechnicianStatus: Codable {
    var timing: OrderTime?
    var title: String?
    var status: Bool?
    var _id: String?

}
