//
//  NewOrderDetailScreen.swift
//  Khebra
//
//  Created by Sheheryar on 04/09/2022.
//

import SwiftUI
import MapKit
struct NewOrderDetailScreen: View {
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
                TopNavigation(titleText: "New Order Details")
                
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

                            
                            Map(coordinateRegion: $region)
                                    
                               
                            
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
                        
                        if isssueInvoice {
                            Group {
                                VStack{
                                    HStack{
                                        Text("Please enter the work fee without VAT")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color("5F5E5E"))
                                            .fontWeight(.regular)
                                        
                                        Spacer()
                                    }.padding(.leading,25)
                                    InvoiceTextField(value: $workfee)
                                }.padding(.vertical,10)
                                
                                VStack{
                                    HStack{
                                        Text("Please enter the cost of spare parts (if any)")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color("5F5E5E"))
                                            .fontWeight(.regular)
                                        
                                        Spacer()
                                    }.padding(.leading,25)
                                    InvoiceTextField(value: $costofSpare)
                                }.padding(.vertical,10)
                                
                                VStack{
                                    HStack{
                                        Text("Please enter the cost of spare parts delivery (if any)")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color("5F5E5E"))
                                            .fontWeight(.regular)
                                        
                                        Spacer()
                                    }.padding(.leading,25)
                                    InvoiceTextField(value: $sparePartDelivery)
                                }.padding(.vertical,10)
                                
                                VStack{
                                    HStack{
                                        Text("Please enter the Tax Number (if any)")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color("5F5E5E"))
                                            .fontWeight(.regular)
                                        
                                        Spacer()
                                    }.padding(.leading,25)
                                    InvoiceTextField(value: $taxNumber)
                                }.padding(.vertical,10)
                                
                                VStack{
                                    HStack{
                                        Text("Please enter the Technician Fare (if any)")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color("5F5E5E"))
                                            .fontWeight(.regular)
                                        
                                        Spacer()
                                    }.padding(.leading,25)
                                    InvoiceTextField(value: $technicianFare)
                                }.padding(.vertical,10)
                                
                                VStack{
                                    HStack{
                                        Text("Please upload the spare parts invoice")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color("5F5E5E"))
                                            .fontWeight(.regular)
                                        
                                        Spacer()
                                    }.padding(.leading,25)
                                    ZStack{
                                      
                                        RoundedRectangle(cornerRadius: 0)
                                             .foregroundColor(Color("White"))
                                        
                                        RoundedRectangle(cornerRadius: 0)
                                            .stroke(Color("B2C1E3"),lineWidth: 1)
                                            .overlay(
                                                HStack{
                                                    Image("thumbnail")
                                                        .scaledToFit()
                                                    
                                                    Text("Upload File")
                                                        .font(.system(size: 14))
                                                        .foregroundColor(Color("B2C1E3"))
                                                        .fontWeight(.regular)
                                                }.padding(.leading)
                                            )
                                    }.frame(width: UIScreen.main.bounds.width - 50, height: 45, alignment: .center)
                                }.padding(.vertical,10)
                                
                                
                                
                                VStack
                                {
                                    CustomButton(title: "Send to Customer", callback: {
                                        showPreloader = true
                                        let invoiceobj = InvoiceObject()
                                        invoiceobj.workFee = Int(workfee)
                                        invoiceobj.sparePartDelivery = Int(sparePartDelivery)
                                        invoiceobj.spareParts = Int(costofSpare)
                                        invoiceobj.taxNumber = Int(taxNumber)
                                        invoiceobj.technicianFare = Int(technicianFare)
                                        invoiceobj.url = ""
                                        
                                        technicianApi.generateInvoice(orderId: serviceManager.selectedNewOrder?._id ?? "" , body: invoiceobj, success: { _ in
                                            showPreloader = false
                                            viewRouter.goBack()
                                        }, failure:  { _ in
                                            showPreloader = false
                                        })
                                    })
                                }.padding(.vertical,20)
                            }
                            .padding(.top)
                           
                        }
                       
                        if !isssueInvoice {
                            VStack
                            {
                                HStack{
                                    NewOrderButton(title: "Issuance of invoice")
                                        .onTapGesture {
                                            isssueInvoice.toggle()
                                        }
                                    NewOrderButton(title: "Postponement Request")
                                    NewOrderButton(title: "Call Customer")
                                }
                            }.padding(.vertical)
                        }
                        
                       
                    }
                }
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
            .task{
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: serviceManager.selectedNewOrder?.location?.coordinates?[0] ?? 0.0,
                                                                           longitude:serviceManager.selectedNewOrder?.location?.coordinates?[1] ?? 0.0),
                                            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            }
    }
}

struct NewOrderDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewOrderDetailScreen()
    }
}
