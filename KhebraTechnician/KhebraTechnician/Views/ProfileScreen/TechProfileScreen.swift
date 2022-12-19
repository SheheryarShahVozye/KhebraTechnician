//
//  TechProfileScreen.swift
//  Khebra
//
//  Created by Sheheryar on 05/09/2022.
//

import SwiftUI

struct TechProfileScreen: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var name: String = AppUtil.TechProfile?.name ?? ""
    @State var email: String = AppUtil.TechProfile?.email ?? ""
    @State var mobileNo: String = AppUtil.TechProfile?.phone ?? ""
    @State var address: String = AppUtil.TechProfile?.city ?? ""
    @State var commercialId: String = AppUtil.TechProfile?.commercialRegistrationNumber ?? ""
    @State var regId: String = ""
    @State var showError: Bool =  false
    @State var showMessage: String =  ""
    @State var showPreloader: Bool = false
    var body: some View {
        ZStack{
            VStack{
                TopNavigation(titleText: "Profile")
                ScrollView{
                    VStack{
                        Group{
                            HStack{
                                ZStack{
                                    Image("plumber-with-his-arms-crossed")
                                        .shadow(radius: 1)
                                        .scaledToFit()
                                    Circle()
                                        .frame(width: 32, height: 32, alignment: .center)
                                        .foregroundColor(Color("White"))
                                        .shadow(radius: 1)
                                        .overlay(
                                            Image("cameraYellow")
                                                .scaledToFit()
                                        ).offset(x: 30, y: 35)
                                    
                                }.frame(width: 32, height: 34, alignment: .center)
                                
                            }.padding(.vertical,40)
                            VStack{
                                HStack{
                                    Image("User")
                                        .scaledToFit()
                                    Text("Name")
                                        .font(.system(size: 16))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("5F5E5E"))
                                    
                                    Spacer()
                                }.padding(.horizontal,30)
                                
                                CustomTextField(value: $name, placeHolder: "Name")
                            }.padding(.top,5)
                            
                            VStack{
                                HStack{
                                    Image("Mail")
                                        .scaledToFit()
                                    Text("Email")
                                        .font(.system(size: 16))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("5F5E5E"))
                                    
                                    Spacer()
                                }.padding(.horizontal,30)
                                
                                CustomTextField(value: $email, placeHolder: "Email")
                            }.padding(.top,5)
                            
                            VStack{
                                HStack{
                                    Image("mobileNo")
                                        .scaledToFit()
                                    Text("Mobile No.")
                                        .font(.system(size: 16))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("5F5E5E"))
                                    
                                    Spacer()
                                }.padding(.horizontal,30)
                                
                                CustomTextField(value: $mobileNo, placeHolder: "Mobile No")
                            }.padding(.top,5)
                        }
                        
                        
                        VStack{
                            HStack{
                                Image("ID Card")
                                    .scaledToFit()
                                Text("ID/Iqama No.")
                                    .font(.system(size: 16))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("5F5E5E"))
                                
                                Spacer()
                            }.padding(.horizontal,30)
                            
                            CustomTextField(value: $regId, placeHolder: "")
                        }.padding(.top,5)
                        
                        RoundedRectangle(cornerRadius: 0)
                            .frame(width: UIScreen.main.bounds.width - 50, height: 45, alignment: .center)
                            .foregroundColor(Color("White"))
                            .shadow(radius: 0.5)
                            .overlay(
                                HStack{
                                    Image("thumbnail")
                                        .scaledToFit()
                                    Text("Upload photo ID")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("B2C1E3"))
                                        .fontWeight(.medium)
                                    Spacer()
                                }.padding(.horizontal)
                            )
                        
                        HStack{
                            Image("Rectangle 99")
                                .scaledToFit()
                            Spacer()
                        }.padding(.horizontal,25)
                            .padding(.top,5)
                        
                        VStack{
                            HStack{
                                Image("comNo")
                                    .scaledToFit()
                                Text("Commercial Registration No")
                                    .font(.system(size: 16))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color("5F5E5E"))
                                
                                Spacer()
                            }.padding(.horizontal,30)
                            
                            CustomTextField(value: $commercialId, placeHolder: "")
                        }.padding(.top,5)
                        
                        RoundedRectangle(cornerRadius: 0)
                            .frame(width: UIScreen.main.bounds.width - 50, height: 45, alignment: .center)
                            .foregroundColor(Color("White"))
                            .shadow(radius: 0.5)
                            .overlay(
                                HStack{
                                    Image("thumbnail")
                                        .scaledToFit()
                                    Text("Upload the commercial register")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("B2C1E3"))
                                        .fontWeight(.medium)
                                    Spacer()
                                }.padding(.horizontal)
                            )
                        
                        HStack{
                            Image("Rectangle 99")
                                .scaledToFit()
                            Spacer()
                        }.padding(.horizontal,25)
                            .padding(.top,5)
                        
                        
                        
                        OrderButton(title: "Save", callback: {
                            showPreloader = true
                            let customerprofile = ProfilePostBody()
                            //   customerprofile.address = address
                            customerprofile.name = name
                            customerprofile.email = email
                            customerprofile.phone = mobileNo
                            customerprofile.commercialRegistrationNumber = commercialId
                            customerprofile.idNumber = regId
                            
                            technicianApi.updateTechnician(customerprofile, success: { res in
                                showPreloader = false
                                viewRouter.goBack()
                            }, failure: { f in
                                showPreloader = false
                                showMessage = f
                                showError.toggle()
                                
                            })
                        }).padding(.vertical)
                        
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
            
            if showError {
                errorDialogBox(message: showMessage,error: $showError)
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .ignoresSafeArea(.all)
            .background(Color("appbg"))
            
            .onAppear(perform: {
                name = AppUtil.TechProfile?.name ?? ""
                email = AppUtil.TechProfile?.email ?? ""
                mobileNo = AppUtil.TechProfile?.phone ?? ""
               // address = AppUtil.TechProfile?.address ?? ""
                regId = AppUtil.TechProfile?.idNumber ?? ""
                commercialId = AppUtil.TechProfile?.commercialRegistrationNumber ?? ""
            })
    }
}

struct errorDialogBox: View {
    var message: String
    @Binding var error: Bool
    var body: some View{
        ZStack{
            VStack {}
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("B6BAC3"))
                .edgesIgnoringSafeArea(.all)
                .opacity(0.6)


            
            VStack{
                
               

                HStack{
                    Text(message)
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color("5F5E5E"))
                        .multilineTextAlignment(.center)
                        
                }.padding(.horizontal)
              
            }.frame(width: UIScreen.main.bounds.width - 50,height: 200)
                .cornerRadius(10)
                .background(Color("FAFCFF"))
                .border(Color("5F5E5E"))
               
            
        }
        .onTapGesture {
            error.toggle()
        }
    }
    
}

