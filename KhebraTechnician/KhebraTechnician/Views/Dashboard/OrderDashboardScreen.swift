//
//  OrderDashboardScreen.swift
//  Khebra
//
//  Created by Sheheryar on 04/09/2022.
//

import SwiftUI

struct OrderDashboardScreen: View {
    @State var selected: String = "New Order"
    @State var textcolorNon: String = "B2C1E3"
    @State var newOrders: [AssignedOrderObjectElement] = []
    @State var defferedOrders: [AssignedOrderObjectElement] = []
    @State var completedOrders: [AssignedOrderObjectElement] = []
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var serviceManager: ServiceManager
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    
                    ToggleView(isOn: .constant(false)) {
                        Color("137D3B") //you can put anything Image, Color, View.... & you can use different images depending on the toggle state using an if statement
                    }.frame(width: 40, height: 30)
                    Text("Available")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(Color("137D3B"))
                        .padding(.leading)
                    
                    
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 1)
                            .foregroundColor(Color("White"))
                        RoundedRectangle(cornerRadius: 1)
                            .stroke(Color("B2C1E3"),lineWidth: 1)
                            .overlay(
                                HStack{
                                    Text("Balance")
                                        .font(.system(size: 15))
                                        .foregroundColor(Color("B2C1E3"))
                                        .fontWeight(.medium)
                                    
                                    Text("0.00")
                                        .font(.system(size: 15))
                                        .foregroundColor(Color("buttonbg"))
                                        .fontWeight(.bold)
                                }
                            )
                    }.frame(width: 115, height: 45, alignment: .center)
                        .padding(.leading,10)
                    
                    Spacer()
                    Image("darkBell")
                        .scaledToFit()
                        .padding(.trailing)
                    
                }.padding(.top,70)
                    .padding(.horizontal)
                VStack{
                    RoundedRectangle(cornerRadius: 7)
                        .foregroundColor(Color("White"))
                        .frame(width: UIScreen.main.bounds.width - 50, height: 60, alignment: .center)
                        .shadow(radius: 1)
                        .overlay(
                            HStack{
                                Group{
                                    if selected == "New Order" {
                                        RoundedRectangle(cornerRadius: 7)
                                            .foregroundColor(Color("fontBlue"))
                                            .overlay(
                                                Text("New Order")
                                                    .foregroundColor(Color("White"))
                                                    .font(.system(size: 14))
                                                    .fontWeight(.regular)
                                                
                                            )
                                    } else {
                                        Text("New Order")
                                            .foregroundColor(Color(textcolorNon))
                                            .font(.system(size: 14))
                                            .fontWeight(.regular)
                                            .onTapGesture {
                                                selected = "New Order"
                                            }
                                    }
                                }.frame(width: 100, height: 50, alignment: .center)
                                
                                
                                
                                Spacer()
                                Group {
                                    if selected == "Deferred" {
                                        RoundedRectangle(cornerRadius: 7)
                                            .foregroundColor(Color("fontBlue"))
                                        
                                            .overlay(
                                                Text("Deferred")
                                                    .foregroundColor(Color("White"))
                                                    .font(.system(size: 14))
                                                    .fontWeight(.regular)
                                                
                                                
                                            )
                                    } else {
                                        Text("Deferred")
                                            .foregroundColor(Color(textcolorNon))
                                            .font(.system(size: 14))
                                            .fontWeight(.regular)
                                            .onTapGesture {
                                                selected = "Deferred"
                                            }
                                    }
                                }.frame(width: 100, height: 50, alignment: .center)
                                
                                
                                Spacer()
                                Group {
                                    if selected == "Completed" {
                                        RoundedRectangle(cornerRadius: 7)
                                            .foregroundColor(Color("fontBlue"))
                                            .overlay(
                                                Text("Completed")
                                                    .foregroundColor(Color("White"))
                                                    .font(.system(size: 14))
                                                    .fontWeight(.regular)
                                                
                                            )
                                    } else {
                                        Text("Completed")
                                            .foregroundColor(Color(textcolorNon))
                                            .font(.system(size: 14))
                                            .fontWeight(.regular)
                                            .onTapGesture {
                                                selected = "Completed"
                                            }
                                        
                                    }
                                }.frame(width: 100, height: 50, alignment: .center)
                                
                                
                                
                            }.padding(.horizontal)
                        ).padding(.vertical,10)
                    ScrollView{
                        
                        if selected == "New Order" {
                            ForEach(0 ..< newOrders.count,id:\.self) { item in
                                TechOrderDetailCard(orderNumber: String(newOrders[item].orderNumber ?? 0),
                                                    name: newOrders[item].customer?.name ?? "",
                                                    serviceName: newOrders[item].serviceName ?? "")
                                    .onTapGesture{
                                        serviceManager.selectedNewOrder = newOrders[item]
                                        viewRouter.currentPage = "NewOrderDetailScreen"
                                    }
                            }
                        } else if selected == "Deferred" {
                            ForEach(0 ..< defferedOrders.count,id:\.self) { item in
                                TechOrderDetailCard(orderNumber: String(defferedOrders[item].orderNumber ?? 0),
                                                    name: defferedOrders[item].customer?.name ?? "",
                                                    serviceName: defferedOrders[item].serviceName ?? "")
                                    .onTapGesture{
                                        serviceManager.selectedNewOrder = defferedOrders[item]
                                        viewRouter.currentPage = "NewOrderDetailScreen"
                                    }
                            }
                        } else {
                            ForEach(0 ..< completedOrders.count,id:\.self) { item in
                                TechOrderDetailCard(orderNumber: String(completedOrders[item].orderNumber ?? 0),
                                                    name: completedOrders[item].customer?.name ?? "",
                                                    serviceName: completedOrders[item].serviceName ?? "")
                                    .onTapGesture{
                                        serviceManager.selectedNewOrder = completedOrders[item]
                                        viewRouter.currentPage = "NewOrderDetailScreen"
                                    }
                            }
                        }
                        
                        
                    }.padding(.top)
                    BottomNavTechnician()
                }
                
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .ignoresSafeArea(.all)
            .background(Color("appbg"))
            .task {
                technicianApi.getNewOrders(success: { res in
                    newOrders = res
                }, failure: { _ in
                    
                })
                
                technicianApi.getDeferedOrders(success: { res in
                    defferedOrders = res
                }, failure: { _ in
                    
                })
                
                technicianApi.getCompletedOrders(success: { res in
                    completedOrders = res
                }, failure: { _ in
                    
                })
            }
    }
}

struct OrderDashboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        OrderDashboardScreen()
    }
}
