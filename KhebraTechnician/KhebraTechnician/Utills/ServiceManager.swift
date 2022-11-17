//
//  ServiceManager.swift
//  Khebra
//
//  Created by Sheheryar on 19/09/2022.
//

import Foundation

class ServiceManager: ObservableObject {

    @Published var services: [Service] = []
    @Published var selectedServiceId: Service?
    @Published var createdOrderData: CreateOrderResponse?
    @Published var selectedLocation: String?
    @Published var selectedIncomingOrder: IncomingOrder?
    @Published var selectedNewOrder: AssignedOrderObjectElement?
    @Published var notificationOrder: IncomingOrder?
    
}
