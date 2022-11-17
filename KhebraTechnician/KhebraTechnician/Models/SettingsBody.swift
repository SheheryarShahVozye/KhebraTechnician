//
//  SettingsBody.swift
//  KhebraTechnician
//
//  Created by apple on 29/10/2022.
//

import Foundation

public class SettingsObject: Codable {
    public var dob: String?
    public var city: String?
}

public class changePasswordObject: Codable {
    public var oldPassword: String?
    public var password: String?
}

public class msgBody: Codable {
    public var msg: String?
}
