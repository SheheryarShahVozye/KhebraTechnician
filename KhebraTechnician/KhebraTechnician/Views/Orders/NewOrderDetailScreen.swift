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
    @State var showPreloader: Bool = false
    @State var isssueInvoice: Bool = false
    @State var workfee: String = ""
    @State var costofSpare: String = ""
    @State var sparePartDelivery: String = ""
    @State var taxNumber: String = ""
    @State var technicianFare: String = ""
    @State var showPostponement: Bool = false
    @State var showError: Bool = false
    @State var showMessage: String = ""
    @State var orderDate: Date = Date()
    @State var orderTime: Date = Date()
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
                                       // invoiceobj.url = ""
                                        
                                        technicianApi.generateInvoice(orderId: serviceManager.selectedNewOrder?._id ?? "" , body: invoiceobj, success: { _ in
                                            showPreloader = false
                                            viewRouter.goBack()
                                        }, failure:  { f in
                                            showMessage = f
                                            showPreloader = false
                                            showError.toggle()
                                        })
                                    })
                                }.padding(.vertical,20)
                            }
                            .padding(.top)
                           
                        }
                        
                        
                        if (serviceManager.selectedNewOrder?.technicianStatus?.count ?? 0) > 0 && (serviceManager.selectedNewOrder?.technicianStatus?.count ?? 0) < 2 {
                            VStack{
                                NewOrderButton(title: "On the Way")
                                    .onTapGesture{
                                        showPreloader = true
                                        technicianApi.updateTechStatusToWay(orderId: serviceManager.selectedNewOrder?._id ?? "", success: { res in
                                            showPreloader = false
                                          //  serviceManager.selectedNewOrder = res.order
                                           // serviceManager.selectedNewOrder?.technicianStatus?.order = "way"
                                            viewRouter.goBack()
                                        }, failure: { f in
                                            showMessage = f
                                            showPreloader = false
                                            showError.toggle()
                                        })
                                    }
                            }
                            
                            
                        }
                        
                        if (serviceManager.selectedNewOrder?.technicianStatus?.count ?? 0) > 1 && (serviceManager.selectedNewOrder?.technicianStatus?.count ?? 0) < 3 {
                            VStack{
                                NewOrderButton(title: "Arrived")
                                    .onTapGesture{
                                        showPreloader = true
                                        technicianApi.updateTechStatusToArrive(orderId: serviceManager.selectedNewOrder?._id ?? "", success: { _ in
                                            showPreloader = false
                                            //serviceManager.selectedNewOrder?.technicianStatus?.order = "arrived"
                                            viewRouter.goBack()
                                        }, failure: { f in
                                            showMessage = f
                                            showPreloader = false
                                            showError.toggle()
                                           
                                        })
                                    }
                            }
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
                                        .onTapGesture{
                                            showPostponement.toggle()
                                        }
                                    NewOrderButton(title: "Call Customer")
                                        .onTapGesture {
                                            let telephone = "tel://"
                                            let formattedString = telephone + (serviceManager.selectedNewOrder?.customer?.phone ?? "")
                                            guard let url = URL(string: formattedString) else { return }
                                            UIApplication.shared.open(url)
                                        }
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
            
            if showPostponement {
                VStack {}
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("B6BAC3"))
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.6)
                
                VStack{
                    VStack{
                        
                        HStack{
                           Spacer()
                            Text("Order Postponement")
                                .foregroundColor(Color("fontBlue"))
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                                .padding(10)
                            Spacer()
                        }
                        
                       
                        HStack{
                            Text("Select Date & Time")
                                .font(.system(size: 16))
                                .foregroundColor(Color("fontBlue"))
                                .fontWeight(.light)
                                .padding(.top,5)
                        }
                        
                        
                        HStack{
                            Spacer()
                            VStack{
                                HStack{
                                    Text("Time")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color("fontBlue"))
                                        .fontWeight(.light)
                                        .padding(.top,5)
                                    
                                    Spacer()
                                }
                                HStack{
                                    Spacer()
                                    Image("ondemand")
                                        .scaledToFit()
                                    DatePicker(selection: $orderTime,displayedComponents: .hourAndMinute, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
                                        .labelsHidden()
                                    
                                    
                                    Spacer()
                                }.padding(.vertical,10)
                                    .padding(.horizontal,10)
                                    .background(Color("White"))
                                    .border(Color("B2C1E3").opacity(0.6))
                            }
                            
                            
                            Group{
                                VStack{
                                    HStack{
                                        Text("Date")
                                            .font(.system(size: 16))
                                            .foregroundColor(Color("fontBlue"))
                                            .fontWeight(.light)
                                            .padding(.top,5)
                                        
                                        Spacer()
                                    }
                                    HStack{
                                        Spacer()
                                        Image("appointment")
                                            .scaledToFit()
                                        DatePicker(selection: $orderDate ,displayedComponents: .date, label: { Text("Date") })
                                            .labelsHidden()
                                        Spacer()
                                    }.padding(.vertical,10)
                                        .padding(.horizontal,10)
                                        .background(Color("White"))
                                        .border(Color("B2C1E3").opacity(0.6))
                                }
                                
                            }.offset(x:-10)
                            
                            Spacer()
                            
                            
                            
                        }.frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .padding(.top,10)
                    
                    
                    
                    
                    OrderButton(title: "Send Request", callback: {
                        let body = postponementRequest()
                        body.date = AppUtil.getPostDateString(orderDate)
                        body.time = AppUtil.getAmPmTime(orderTime)
                        showPostponement = false
                        technicianApi.postponeOrder(serviceManager.selectedNewOrder?._id ?? "",body, success: { _ in
                            showPostponement = false
                            viewRouter.goBack()
                        }, failure: { f in
                            showPostponement = false
                            showMessage = f
                            showError.toggle()

                        })
                    }).padding(.top)
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width - 20,
                        height: 300, alignment: .center)
                    .background(Color("White"))
            }
            
            
            if showError {
                errorDialogBox(message: showMessage,error: $showError)
            }
          
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .ignoresSafeArea(.all)
            .background(Color("appbg"))
            
    }
}

struct NewOrderDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewOrderDetailScreen()
    }
}
