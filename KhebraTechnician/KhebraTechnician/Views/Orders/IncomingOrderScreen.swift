//
//  IncomingOrderScreen.swift
//  Khebra
//
//  Created by Sheheryar on 04/09/2022.
//

import SwiftUI
import MapKit

struct IncomingOrderScreen: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var serviceManager: ServiceManager
    @State var showPreloader: Bool = false
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    
    var body: some View {
        ZStack{
          
            VStack{
                TopNavigation(titleText: "Incoming Order Details")
                
                ScrollView{
                    VStack{
                        OrderNumCard()
                        
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
//                            Image("MapSmall")
//                                .resizable()
                            
                            
                         GoogleMapsView(longitude: serviceManager.selectedIncomingOrder?.location?.coordinates?[0] ?? 0.0, latitude: serviceManager.selectedIncomingOrder?.location?.coordinates?[1] ?? 0.0)
                                      //  .frame(width: 400, height: 300)
                               
                            
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
                                        Text(serviceManager.selectedIncomingOrder?.customer?.name ?? "")
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
                                        Text(AppUtil.getDateOnly(format: "", dateValue: serviceManager.selectedIncomingOrder?.scheduled?.date ?? "")
                                             +  ", " +
                                             (serviceManager.selectedIncomingOrder?.orderTime?.time ?? ""))
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
                                        Text("Address")
                                            .font(.system(size: 14))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color("B2C1E3"))
                                        Spacer()
                                    }
                                    HStack{
                                        Text(serviceManager.selectedIncomingOrder?.address ?? "")
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
                                OrderButton(title: "Apply Now", callback: {
                                    showPreloader = true
                                    technicianApi.applyForOrder(orderId: String(serviceManager.selectedIncomingOrder?._id ?? ""), success: { _ in
                                        showPreloader = false
                                        viewRouter.currentPage = "ApplicationCompleteScreen"
                                        
                                    }, failure: { _ in
                                        showPreloader = false
                                    })
                                })
                            }
                        }.padding(.vertical)
                    }
                }
                BottomNavTechnician()
            }
           
            if showPreloader {
                VStack {}
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("B6BAC3"))
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.6)

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("buttonbg")))
                    .scaleEffect(x: 4, y: 4, anchor: .center)
            }
          
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .ignoresSafeArea(.all)
            .background(Color("appbg"))
            .onAppear(perform: {
                DispatchQueue.main.async {
                    region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: serviceManager.selectedIncomingOrder?.location?.coordinates?[0] ?? 0.0,
                                                                               longitude:serviceManager.selectedIncomingOrder?.location?.coordinates?[1] ?? 0.0),
                                                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                }
              
            })
           
    }
}

struct IncomingOrderScreen_Previews: PreviewProvider {
    static var previews: some View {
        IncomingOrderScreen()
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct DottedLine: Shape {
        
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        return path
    }
}

struct TestDottedLineView: View {
    var body: some View {
        DottedLine()
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
            .frame(width: 1, height: 100)
            .foregroundColor(Color.red)
    }
}
