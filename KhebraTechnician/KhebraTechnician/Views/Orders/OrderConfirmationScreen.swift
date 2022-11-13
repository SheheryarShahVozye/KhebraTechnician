//
//  OrderConfirmationScreen.swift
//  KhebraTechnician
//
//  Created by apple on 13/11/2022.
//

import SwiftUI

struct OrderConfirmationScreen: View {
    var body: some View {
        ZStack{
            VStack{
                TopNavigation(titleText: "Notification")
                ScrollView{
                    VStack{
                        Text("The customer has sent you order Request")
                            .font(.system(size: 18))
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
                                
                                Text("SHEHERYAR")
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
                                
                                Text("SHEHERYAR")
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
                                
                                Text("SHEHERYAR")
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
                                
                                Text("SHEHERYAR")
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("5A5A5A"))
                                Spacer()
                            }.padding(.top,1)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                }
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
