//
//  profileBody.swift
//  Khebra
//
//  Created by Sheheryar on 17/09/2022.
//

import Foundation


class ProfilePostBody: Codable {
   public var name, email, phone,idNumber,commercialRegistrationNumber,url,urls: String?

   
}

class ErrorObject: Codable {
    var code: Int?
    var msg: String?
    var success: Bool?
    var error: String?

   
}
