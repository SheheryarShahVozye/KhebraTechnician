//
//  RegisterPasswordScreen.swift
//  Khebra
//
//  Created by Sheheryar on 03/09/2022.
//

import SwiftUI

struct RegisterPasswordScreen: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var showPreloader: Bool = false
    @State var togglepopup: Bool = false
    @State var errorMessage: String = ""
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Image("registerPassword")
                    .scaledToFit()
                    .padding(.vertical)
              
                VStack{
                   
                    HStack{
                        Text("Register password")
                            .bold()
                            .font(.system(size: 25))
                            .foregroundColor(Color("fontBlue"))
                        Spacer()
                        
                    }.padding(.vertical,20)
                        .padding(.horizontal,20)
                    
                    HStack{
                        Text("Please enter the password")
                            .font(.custom("STCRegular", size: 14))
                            .foregroundColor(Color("5F5E5E"))
                        Spacer()
                        
                    }.padding(.horizontal,25)
                   
                    passwordTextField(value: $password,placeHolder: "Enter Password")
                        .padding(.vertical,5)
                  
                    if viewRouter.previousPage == "SignUpScreen" {
                        passwordTextField(value: $confirmPassword,placeHolder: "Confirm Password")
                            .padding(.vertical,5)
                    }
                    
                    HStack{
                        Spacer()
                        Text("Forgot Your Password?")
                            .font(.custom("STCRegular", size: 14))
                            .foregroundColor(Color("fontBlue"))
                       
                        
                    }.padding(.top)
                        .padding(.horizontal)
                    
                    CustomButton(title: "Login", callback: {
                        showPreloader = true
                        if viewRouter.previousPage == "SignUpScreen" && confirmPassword ==  password {
                            let registerBody = RegisterTechnicianBody();
                            registerBody.phone = AppUtil.technicianNumber
                            registerBody.password = password
                            
                            technicianApi.registerTechnician(registerBody, success: { res in
                                showPreloader = false
                                AppUtil.user = res.newUser
                                AppUtil.idToken = res.token ?? ""
                                let defaults = UserDefaults.standard
                                defaults.set(AppUtil.idToken, forKey: Keys.token)

                                
                                if let token = defaults.value(forKey: Keys.token) as? String {
                                    print("defaults Token: \(token)")
                                }
                                viewRouter.currentPage =  "TechnicianDashboard"
                               
                            }, failure: { f in
                                showPreloader = false
                                errorMessage = f
                                togglepopup.toggle()
                            })
                            
                          
                        } else {
                            
                            AppUtil.registerBody?.password = password
                            
                            technicianApi.loginTechnician(AppUtil.registerBody!, success: { res in
                                AppUtil.user = res.user
                                AppUtil.idToken = res.token ?? ""
                                let defaults = UserDefaults.standard
                                defaults.set(AppUtil.idToken, forKey: Keys.token)

                                
                                if let token = defaults.value(forKey: Keys.token) as? String {
                                    print("defaults Token: \(token)")
                                }
                                showPreloader = false
                                viewRouter.currentPage =  "TechnicianDashboard"
                            }, failure: { f in
                                showPreloader = false
                                errorMessage = f
                                togglepopup.toggle()
                            })
                            
                            
                           
                           
                        }
                       
                    }).padding(.top)
                }.padding(.vertical,30)
                Spacer()
                HStack{
                    
                    
                    Text("SIGNUP")
                        .underline()
                        .fontWeight(.regular)
                        .font(.system(size: 12))
                        .foregroundColor(Color("fontBlue"))
                        .onTapGesture {
                            viewRouter.currentPage = "SignUpScreen"
                        }
                }.padding(.vertical,20)

            }
            
            if togglepopup {
                ZStack{
                    
                    VStack {}
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("000000"))
                        .edgesIgnoringSafeArea(.all)
                        .opacity(0.6)
                    
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: UIScreen.main.bounds.width - 50, height: 330, alignment: .center)
                        .foregroundColor(Color("B2C1E3"))
                        .shadow(color: Color("gray").opacity(0.2), radius: 2, x: 0, y: 1)
                        .overlay(
                            VStack{
                                VStack{
                                    Image("ordercancel")
                                        .scaledToFit()
                                }
                                .frame(width: 108, height: 110, alignment: .center)
                                .padding(.vertical)
                                
                                Text("Error?")
                                    .foregroundColor(Color("black"))
                                    .font(Font.custom("poppins", size: 20))
                                    .fontWeight(.bold)
                                
                                Text(errorMessage)
                                    .foregroundColor(Color("black").opacity(0.7))
                                    .font(Font.custom("poppins", size: 12))
                                    .fontWeight(.regular)
                                    .padding(.top,1)
                                
                                HStack{
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 70)
                                            .foregroundColor(Color("White"))
                                        
                                        RoundedRectangle(cornerRadius: 70)
                                            .stroke(Color("buttonbg"),lineWidth: 1)
                                            .overlay(
                                                    Text("OK")
                                                        .foregroundColor(Color("black").opacity(0.4))
                                                        .font(Font.custom("poppins", size: 18))
                                                        .fontWeight(.regular)
                                            )
                                        
                                    }.frame(width: 120, height: 35, alignment: .center)
                                        .onTapGesture{
                                            togglepopup.toggle()
                                        }
                                    
                                   
                                }
                                .frame(width: UIScreen.main.bounds.width - 70)
                                .padding(.vertical)
                                    
                                
                            }
                        )

                }
            }
            
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .ignoresSafeArea(.all)
            .background(Color("appbg"))
    }
}

struct RegisterPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPasswordScreen()
    }
}
