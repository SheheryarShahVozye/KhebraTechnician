//
//  technicianApi.swift
//  Khebra
//
//  Created by Sheheryar on 13/09/2022.
//

import Foundation


class technicianApi {
    
    public static func registerTechnician(_ body: RegisterTechnicianBody,success: @escaping (User) -> Void, failure: @escaping (String) -> Void) {
        let url: String = "technician/register"
        do{
            let jsonData = try JSONEncoder().encode(body)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            print("\n\n\(json ?? "-")\n\n")
            
            customerApi.post(url: url,data:jsonData, completion: { result in
                do {
                    let jsonString = String(data: result!, encoding: .utf8)
                    print("\n\n\(jsonString ?? "-")\n\n")
                    
                    let userObj: User = try JSONDecoder()
                        .decode(User.self, from: result!)
                    
                    success(userObj)
                    
                } catch {
                    print("\n\n\(error)\n at line \(#line)")
                    print("\n\nError in decoding \(error.localizedDescription)\n")
                    failure(Strings.requestApiError)
                    // failure("Error in decoding")
                }
            }, incomplete: { incomp  in
                failure(incomp)
            })
        }  catch {
            print("\n\n\(error)\n at line \(#line)")
            print("\n\nError in encoding \(error.localizedDescription)\n")
            failure(Strings.requestApiError)
            // failure("Error in encoding")
        }
    }
    
    public static func loginTechnician(_ body: RegisterTechnicianBody,success: @escaping (UserResponse) -> Void, failure: @escaping (String) -> Void) {
        let url: String = "technician/login"
        do{
            let jsonData = try JSONEncoder().encode(body)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            print("\n\n\(json ?? "-")\n\n")
            
            customerApi.post(url: url,data:jsonData, completion: { result in
                do {
                    let jsonString = String(data: result!, encoding: .utf8)
                    print("\n\n\(jsonString ?? "-")\n\n")
                    
                    let userObj: UserResponse = try JSONDecoder()
                        .decode(UserResponse.self, from: result!)
                    
                    success(userObj)
                    
                } catch {
                    print("\n\n\(error)\n at line \(#line)")
                    print("\n\nError in decoding \(error.localizedDescription)\n")
                    failure(Strings.requestApiError)
                    // failure("Error in decoding")
                }
            }, incomplete: { incomp  in
                failure(incomp)
            })
        }  catch {
            print("\n\n\(error)\n at line \(#line)")
            print("\n\nError in encoding \(error.localizedDescription)\n")
            failure(Strings.requestApiError)
            // failure("Error in encoding")
        }
    }
    
    public static func availableToggle(success: @escaping (msgResponse) -> Void, failure: @escaping (String) -> Void) {
        let url: String = "technician/available"
        customerApi.get(url: url,completion: { result in
            do {
                let jsonString = String(data: result!, encoding: .utf8)
                print("\n\n\(jsonString ?? "-")\n\n")
                
                let userObj: msgResponse = try JSONDecoder()
                    .decode(msgResponse.self, from: result!)
                
                success(userObj)
                
                
            } catch {
                print("\n\n\(error)\n at line \(#line)")
                print("\n\nError in decoding \(error.localizedDescription)\n")
                failure(Strings.requestApiError)
                // failure("Error in decoding")
            }
        }, incomplete: { incomp  in
            failure(incomp)
        })
        
    }
    
    public static func getIncomingOrders(success: @escaping ([IncomingOrder]) -> Void, failure: @escaping (String) -> Void) {
        let url: String = "technician/order/incoming?lat=33.72148&lng=73.04329&nearMe=25000000"
        customerApi.get(url: url,completion: { result in
            do {
                let jsonString = String(data: result!, encoding: .utf8)
                print("\n\n\(jsonString ?? "-")\n\n")
                
                let userObj: [IncomingOrder] = try JSONDecoder()
                    .decode([IncomingOrder].self, from: result!)
                
                success(userObj)
                
                
            } catch {
                print("\n\n\(error)\n at line \(#line)")
                print("\n\nError in decoding \(error.localizedDescription)\n")
                failure(Strings.requestApiError)
                // failure("Error in decoding")
            }
        }, incomplete: { incomp  in
            failure(incomp)
        })
    }
    
    public static func getTechprofile(success: @escaping (TechnicianProfile) -> Void, failure: @escaping (String) -> Void) {
        let url: String = "technician/profile"
        do{
           
           
            customerApi.get(url: url, completion: { result in
                do {
                    let jsonString = String(data: result!, encoding: .utf8)
                    print("\n\n\(jsonString ?? "-")\n\n")
                    
                    let userObj: TechnicianProfile = try JSONDecoder()
                        .decode(TechnicianProfile.self, from: result!)
                    
                    success(userObj)
                    
                } catch {
                    print("\n\n\(error)\n at line \(#line)")
                    print("\n\nError in decoding \(error.localizedDescription)\n")
                    failure(Strings.requestApiError)
                    // failure("Error in decoding")
                }
            }, incomplete: { incomp  in
                failure(incomp)
            })
        }
    }
    
    
    public static func applyForOrder(orderId: String,success: @escaping ([IncomingOrder]) -> Void, failure: @escaping (String) -> Void) {
        let url: String = "technician/order/" + orderId + "/applynow"
        customerApi.get(url: url,completion: { result in
            do {
                let jsonString = String(data: result!, encoding: .utf8)
                print("\n\n\(jsonString ?? "-")\n\n")
                
                let userObj: [IncomingOrder] = try JSONDecoder()
                    .decode([IncomingOrder].self, from: result!)
                
                success(userObj)
                
                
            } catch {
                print("\n\n\(error)\n at line \(#line)")
                print("\n\nError in decoding \(error.localizedDescription)\n")
                failure(Strings.requestApiError)
                // failure("Error in decoding")
            }
        }, incomplete: { incomp  in
            failure(incomp)
        })
    }
    
    
}
