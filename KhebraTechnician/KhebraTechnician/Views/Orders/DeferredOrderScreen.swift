//
//  DeferredOrderScreen.swift
//  Khebra
//
//  Created by Sheheryar on 04/09/2022.
//

import SwiftUI
import MapKit

struct DeferredOrderScreen: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var serviceManager: ServiceManager
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State var showPreloader: Bool = false
    @State var isssueInvoice: Bool = false
    @State var workfee: String = ""
    @State var costofSpare: String = ""
    @State var sparePartDelivery: String = ""
    @State var taxNumber: String = ""
    @State var technicianFare: String = ""
    
    var body: some View {
        ZStack{
            VStack{
                TopNavigation(titleText: "Deferred Order Details")
                
                ScrollView{
                    VStack{
                        OrderNumCard(orderNumber: String(serviceManager.selectedNewOrder?.orderNumber ?? 0 ))
                        HStack{
                            VStack{
                                HStack{
                                    VStack {
                                        Image("darkBluemarker")
                                            .scaledToFit()
                                        Spacer()
                                    }.padding(.bottom,5)
                                    VStack{
                                        HStack {
                                            Text("Order Location")
                                                .font(.system(size: 16))
                                                .fontWeight(.bold)
                                            .foregroundColor(Color("fontBlue"))
                                            Spacer()
                                        }
                                       
                                        Line().stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
                                                  .frame(height: 1)
                                                  .foregroundColor(Color("B2C1E3"))
                                        
                                    }
                                    Spacer()
                                }
                            }.padding(.horizontal)
                                .padding(.top,20)
                        }
                        VStack{

                            
                            GoogleMapsView(longitude: serviceManager.selectedNewOrder?.location?.coordinates?[0] ?? 0.0, latitude: serviceManager.selectedNewOrder?.location?.coordinates?[1] ?? 0.0)
                                    
                               
                            
                        }.frame(width: UIScreen.main.bounds.width - 50, height: 180, alignment: .center)
                            .padding(.vertical,10)
                       
                        VStack{
                            HStack{
                                VStack {
                                    Image("user_big_outlined")
                                        .resizable()
                                        .frame(width: 15, height: 15, alignment: .center)
                                        .scaledToFit()
                                    Spacer()
                                }
                                VStack{
                                    HStack{
                                        Text("Customer")
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color("B2C1E3"))
                                        Spacer()
                                    }
                                    HStack{
                                        Text(serviceManager.selectedNewOrder?.customer?.name ?? "")
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color("5A5A5A"))
                                        Spacer()
                                    }.padding(.top,1)
                                }.padding(.horizontal,5)
                            }.padding(.horizontal,20)
                            HStack{
                                VStack {
                                    Image("time")
                                        .resizable()
                                        .frame(width: 15, height: 15, alignment: .center)
                                        .scaledToFit()
                                    Spacer()
                                }
                                VStack{
                                    HStack{
                                        Text("Date & time")
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color("B2C1E3"))
                                        Spacer()
                                    }
                                    HStack{
                                        Text(serviceManager.selectedNewOrder?.scheduled?.time ?? "")
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color("5A5A5A"))
                                        
                                        Text(" " + (AppUtil.getDateOnly(format: "", dateValue: serviceManager.selectedNewOrder?.scheduled?.date ?? "") ))
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color("5A5A5A"))
                                        
                                        Spacer()
                                    }.padding(.top,1)
                                }.padding(.horizontal,5)
                            }.padding(.horizontal,20)
                            HStack{
                                VStack {
                                    Image("address")
                                        .resizable()
                                        .frame(width: 15, height: 15, alignment: .center)
                                        .scaledToFit()
                                    Spacer()
                                }
                                VStack{
                                    HStack{
                                        Text("Address")
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color("B2C1E3"))
                                        Spacer()
                                    }
                                    HStack{
                                        Text(serviceManager.selectedNewOrder?.address ?? "")
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color("5A5A5A"))
                                        Spacer()
                                    }.padding(.top,1)
                                }.padding(.horizontal,5)
                            }.padding(.horizontal,20)
                        }
                        .padding(.top)
                        
                        VStack
                        {
                            HStack{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 0)
                                        .foregroundColor(Color("White"))
                                    RoundedRectangle(cornerRadius: 0)
                                        .stroke(Color("buttonbg"),lineWidth: 1)
                                        .overlay(
                                            HStack{
                                                Image("android_phone")
                                                    .scaledToFit()
                                                
                                                Text("Call Customer")
                                                    .font(.system(size: 16))
                                                    .foregroundColor(Color("buttonbg"))
                                            }
                                        )
                                    
                                }.frame(width: UIScreen.main.bounds.width - 75, height: 50, alignment: .center)
                              
                                
                            } .onTapGesture {
                                let telephone = "tel://"
                                let formattedString = telephone + (serviceManager.selectedNewOrder?.customer?.phone ?? "")
                                guard let url = URL(string: formattedString) else { return }
                                UIApplication.shared.open(url)
                            }
                            
                        }.padding(.vertical,20)
                    }
                }
                BottomNavTechnician()
            }
          
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .ignoresSafeArea(.all)
            .background(Color("appbg"))
            .task{
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: serviceManager.selectedNewOrder?.location?.coordinates?[0] ?? 0.0,
                                                                           longitude:serviceManager.selectedNewOrder?.location?.coordinates?[1] ?? 0.0),
                                            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            }
    }
}

struct DeferredOrderScreen_Previews: PreviewProvider {
    static var previews: some View {
        DeferredOrderScreen()
    }
}
