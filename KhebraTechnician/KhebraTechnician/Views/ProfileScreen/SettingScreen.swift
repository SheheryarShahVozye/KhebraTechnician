//
//  SettingScreen.swift
//  Khebra
//
//  Created by Sheheryar on 05/09/2022.
//

import SwiftUI

struct SettingScreen: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var dateOfBirth: Date = AppUtil.getStringToDate(dateValue: AppUtil.TechProfile?.dob ?? "")
    @State var cityText: String = AppUtil.TechProfile?.city ?? ""
    var body: some View {
        ZStack{
            VStack{
                TopNavigation(titleText: "Setting")
                ScrollView{
                    VStack{
                        VStack{
                            HStack{
                                
                                Text("Date of Birth")
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("5F5E5E"))
                                
                                Spacer()
                            }.padding(.horizontal,30)
                            
                            HStack{
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: UIScreen.main.bounds.width - 50, height: 55, alignment: .center)
                                    .foregroundColor(Color("White"))
                                    .shadow(radius: 1)
                                    .overlay(
                                        HStack{
                                            DatePicker(selection: $dateOfBirth,displayedComponents: .date, label: { })
                                                .labelsHidden()
                                            Spacer()
                                            Image("calendar_month")
                                                .scaledToFit()
                                            
                                        }.padding(.horizontal)
                                    )
                            }
                        }.padding(.top,5)
                        
                        VStack{
                            HStack{
                                
                                Text("City")
                                    .font(.system(size: 14))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("5F5E5E"))
                                
                                Spacer()
                            }.padding(.horizontal,30)
                            
                            HStack{
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: UIScreen.main.bounds.width - 50, height: 55, alignment: .center)
                                    .foregroundColor(Color("White"))
                                    .shadow(radius: 1)
                                    .overlay(
                                        HStack{
                                            TextField("City", text: $cityText)
                                            Spacer()
                                            Image("chevron_down")
                                                .scaledToFit()
                                            
                                        }.padding(.horizontal)
                                    )
                            }
                        }.padding(.top,5)
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: UIScreen.main.bounds.width - 50, height: 45, alignment: .center)
                            .foregroundColor(Color("White"))
                            .shadow(radius: 1)
                            .overlay(
                                HStack{
                                    
                                    Text("Language")
                                        .font(.system(size: 16))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("5F5E5E"))
                                    
                                    Spacer()
                                    Text("EN")
                                        .font(.system(size: 16))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("B2C1E3"))
                                    
                                    
                                }.padding(.horizontal,30)
                                
                            )
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: UIScreen.main.bounds.width - 50, height: 45, alignment: .center)
                            .foregroundColor(Color("White"))
                            .shadow(radius: 1)
                            .overlay(
                                HStack{
                                    
                                    Text("Change Password")
                                        .font(.system(size: 16))
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("5F5E5E"))
                                    Spacer()
                                    Image("chevron_down")
                                        .scaledToFit()
                                        .rotationEffect(Angle(degrees: 270))
                                        .onTapGesture {
                                            viewRouter.currentPage = "ChangePasswordScreen"
                                        }
                                    
                                    
                                    
                                }.padding(.horizontal,30)
                                
                            )
                        
                        OrderButton(title: "Save", callback: {
                            let settingsObj = SettingsObject()
                            settingsObj.city = cityText
                            settingsObj.dob = AppUtil.getprofileDate(dateOfBirth)
                            
                            technicianApi.updateSettings(settingsObj, success: { _ in
                                
                            }, failure: { _ in
                                
                            })
                        })
                    }
                    
                }
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .ignoresSafeArea(.all)
            .background(Color("appbg"))
    }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen()
    }
}
