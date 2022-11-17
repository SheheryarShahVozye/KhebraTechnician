//
//  OrderConfirmationScreen.swift
//  KhebraTechnician
//
//  Created by apple on 13/11/2022.
//

import SwiftUI

struct OrderConfirmationScreen: View {
    @EnvironmentObject var serviceManager: ServiceManager
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        ZStack{
            VStack{
                TopNavigation(titleText: "Notification")
               // ScrollView{
                    VStack{
                        Text("The customer has sent you order Request")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(Color("fontBlue"))
                     
                        VStack{
                            HStack{
                                
                                Image("user_big_outlined")
                                    .resizable()
                                    .frame(width: 15, height: 15, alignment: .center)
                                    .scaledToFit()
                                
                                Text("Customer")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("B2C1E3"))
                                Spacer()
                            }
                            HStack{
                                Image("user_big_outlined")
                                    .resizable()
                                    .frame(width: 15, height: 15, alignment: .center)
                                    .scaledToFit()
                                    .opacity(0)
                                
                                Text(serviceManager.notificationOrder?.customer?.name ?? "")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("5A5A5A"))
                                Spacer()
                            }.padding(.top,1)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        VStack{
                            HStack{
                                
                                Image("time")
                                    .resizable()
                                    .frame(width: 15, height: 15, alignment: .center)
                                    .scaledToFit()
                                
                                Text("Date & Time")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("B2C1E3"))
                                Spacer()
                            }
                            HStack{
                                Image("time")
                                    .resizable()
                                    .frame(width: 15, height: 15, alignment: .center)
                                    .scaledToFit()
                                    .opacity(0)
                                
                                Text((serviceManager.notificationOrder?.orderTime?.date ?? "") + " ")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("5A5A5A"))
                                Text(serviceManager.notificationOrder?.orderTime?.time ?? "")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("5A5A5A"))
                                Spacer()
                            }.padding(.top,1)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        
                        
                        VStack{
                            HStack{
                                
                                Image("address")
                                    .resizable()
                                    .frame(width: 15, height: 15, alignment: .center)
                                    .scaledToFit()
                                
                                Text("Address")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("B2C1E3"))
                                Spacer()
                            }
                            HStack{
                                Image("address")
                                    .resizable()
                                    .frame(width: 15, height: 15, alignment: .center)
                                    .scaledToFit()
                                    .opacity(0)
                                
                                Text(serviceManager.notificationOrder?.address ?? "")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("5A5A5A"))
                                Spacer()
                            }.padding(.top,1)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        Spacer()
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 0)
                                    .foregroundColor(Color("White"))
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color("buttonbg"),lineWidth: 1)
                                    .overlay(
                                        HStack{
                                          
                                            
                                            Text("Reject")
                                                .font(.system(size: 16))
                                                .foregroundColor(Color("buttonbg"))
                                        }
                                    )
                                
                            }.frame(width: 120, height: 50, alignment: .center)
                                .onTapGesture {
                                    technicianApi.acceptOrReject(orderId: serviceManager.notificationOrder?._id ?? "", status: "reject", success: { _ in
                                        viewRouter.currentPage = "OrderDashboardScreen"
                                    }, failure: { _ in
                                        
                                    })
                                }
                            
                            RoundedRectangle(cornerRadius: 2)
                                 .foregroundColor(Color("buttonbg"))
                                 .frame(width: 120, height: 50, alignment: .center)
                                 .overlay(
                                             Text("Accept")
                                                 .font(.system(size: 16))
                                                 .foregroundColor(Color("White"))
                                                 .fontWeight(.semibold)
                                 ).onTapGesture {
                                     technicianApi.acceptOrReject(orderId: serviceManager.notificationOrder?._id ?? "", status: "accept", success: { _ in
                                         viewRouter.currentPage = "OrderDashboardScreen"
                                     }, failure: { _ in
                                         
                                     })
                                 }
                        }
                        .padding(.vertical,30)
                       
                    }
                    .padding(.horizontal)
               // }
            }
            
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .ignoresSafeArea(.all)
            .background(Color("appbg"))
    }
}

struct OrderConfirmationScreen_Previews: PreviewProvider {
    static var previews: some View {
        OrderConfirmationScreen()
    }
}
