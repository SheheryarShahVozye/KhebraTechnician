//
//  TechnicianDashboard.swift
//  Khebra
//
//  Created by Sheheryar on 03/09/2022.
//

import SwiftUI

struct TechnicianDashboard: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var serviceManager: ServiceManager
    @State var availableCheck: Bool = AppUtil.user?.available ?? false
    @State var incomingOrders: [IncomingOrder] = []
    var body: some View {
        ZStack{
            VStack{
                HStack{
                   
//                    ToggleView(isOn: .constant(false)) {
//                        Color("137D3B") //you can put anything Image, Color, View.... & you can use different images depending on the toggle state using an if statement
//                    }.frame(width: 40, height: 30)
                    Toggle(isOn: $availableCheck) {
                        
                    }.labelsHidden()
                        .onChange(of: availableCheck) { newValue in
                            technicianApi.availableToggle(status: availableCheck,success: { res in
//                                if res.msg == "User is inactive now!" {
//                                    availableCheck = false
//                                } else {
//                                    availableCheck = true
//                                }
                               
                            }, failure: { _ in
                                
                            })
                                    }

                    Text(availableCheck ? "Available" : "In-Active")
                        .font(.system(size: 10))
                        .fontWeight(.medium)
                        .foregroundColor(availableCheck ? Color("137D3B") : Color("F44336"))
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
                                    
                                    Text(String(AppUtil.TechProfile?.balance ?? 0))
                                           .font(.system(size: 12))
                                           .foregroundColor(Color("buttonbg"))
                                           .fontWeight(.bold)
                                }
                            )
                    }.frame(width: 90, height: 40, alignment: .center)
                        .padding(.leading,10)
                    
                    Spacer()
                    Image("darkBell")
                        .scaledToFit()
                        .padding(.trailing)
                        .onTapGesture {
                            viewRouter.currentPage = "NotificationScreen"
                        }
                    
                }
                    .padding(.top,70)
                    .padding(.horizontal)
                    .padding(.bottom,20)
             
                ScrollView{
                    VStack{
                        HStack{
                            Text("Incoming Order")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(Color("fontBlue"))
                            
                            Spacer()
                        }
                        VStack{
                            ForEach(0 ..< incomingOrders.count,id:\.self) { ind in
                                TechOrderCard(orderNumber: String(incomingOrders[ind].orderNumber ?? 0)
                                              ,customerName: incomingOrders[ind].customer?.name ?? "",
                                              serviceName: incomingOrders[ind].serviceName ?? "")
                                    .onTapGesture {
                                        serviceManager.selectedIncomingOrder = incomingOrders[ind]
                                        viewRouter.currentPage = "IncomingOrderScreen"
                                    }
                            }
                        }.padding(.vertical)
                       
                        
                        VStack{
                            HStack{
                                Image("techOffer")
                                    .resizable()
                                    .scaledToFill()
                                    
                            }.frame(width: UIScreen.main.bounds.width - 50, height: 140, alignment: .center)
                        }
                        .padding()
                        
                    }.padding(.top)
                        .padding(.horizontal)
                }
                BottomNavTechnician()
                
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .ignoresSafeArea(.all)
            .background(Color("appbg"))
            .task {
                technicianApi.getIncomingOrders(success: { res in
                    incomingOrders = res
                }, failure: { _ in
                    
                })
            }
    }
}

struct TechnicianDashboard_Previews: PreviewProvider {
    static var previews: some View {
        TechnicianDashboard()
    }
}

struct ToggleView<Content: View>: View {
    @Binding var isOn: Bool
    var backGround: Content
    var toggleButton: Content?
    init(isOn: Binding<Bool>, @ViewBuilder backGround: @escaping () -> Content, @ViewBuilder button: @escaping () -> Content? = {nil}) {
        self._isOn = isOn
        self.backGround = backGround()
        self.toggleButton = button()
    }
    var body: some View {
        GeometryReader { reader in
            HStack {
                if isOn {
                    Spacer()
                }
                VStack {
                    if let toggleButton = toggleButton {
                        toggleButton
                            .clipShape(Circle())
                    }else {
                        Circle()
                            .fill(Color.white)
                    }
                }.padding(2.5)
                .frame(width: reader.frame(in: .global).height)
                .onTapGesture {
                    withAnimation {
//                        technicianApi.availableToggle(success: { res in
//                            if res.msg == "User is inactive now!" {
//                                isOn = false
//                            } else {
//                                isOn = true
//                            }
//
//                        }, failure: { _ in
//
//                        })
                       
                    }
                }.modifier(Swipe { direction in
                    if direction == .swipeLeft {
                        withAnimation() {
                           
                           
                        }
                    }else if direction == .swipeRight {
                        withAnimation() {
                           
                        }
                    }
                })
                if !isOn {
                    Spacer()
                }
            }.background(backGround)
            .clipShape(Capsule())
            .frame(width: 50, height: 25)//control the frame or remove it and add it to ToggleView
        }
    }
}

struct Swipe: ViewModifier {
    @GestureState private var dragDirection: Direction = .none
    @State private var lastDragPosition: DragGesture.Value?
    @State var position = Direction.none
    var action: (Direction) -> Void
    func body(content: Content) -> some View {
        content
            .gesture(DragGesture().onChanged { value in
                lastDragPosition = value
            }.onEnded { value in
                if lastDragPosition != nil {
                    if (lastDragPosition?.location.x)! < value.location.x {
                        withAnimation() {
                            action(.swipeRight)
                        }
                    }else if (lastDragPosition?.location.x)! > value.location.x {
                        withAnimation() {
                            action(.swipeLeft)
                        }
                    }
                }
            })
    }
}

enum Direction {
    case none
    case swipeLeft
    case swipeRight
    case swipeUp
    case swipeDown
}
