//
//  ChangePasswordScreen.swift
//  KhebraTechnician
//
//  Created by apple on 29/10/2022.
//

import SwiftUI

struct ChangePasswordScreen: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var password: String = "qwerty"
    @State var confirmPassword: String = ""
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Image("registerPassword")
                    .scaledToFit()
                    .padding(.vertical)
              
                VStack{
                   
                    HStack{
                        Text("Change password")
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
                   
                    passwordTextField(value: $password,placeHolder: "Enter Old Password")
                        .padding(.vertical,5)
                  
                   // if viewRouter.previousPage == "SignUpScreen" {
                        passwordTextField(value: $confirmPassword,placeHolder: "Enter new Password")
                            .padding(.vertical,5)
                  //  }
                    
                    HStack{
                        Spacer()
                        Text("Forgot Your Password?")
                            .font(.custom("STCRegular", size: 14))
                            .foregroundColor(Color("fontBlue"))
                       
                        
                    }.padding(.top)
                        .padding(.horizontal)
                    
                    CustomButton(title: "Login", callback: {
                       let changePassObj = changePasswordObject()
                        changePassObj.oldPassword = password
                        changePassObj.password = confirmPassword
                        
                        technicianApi.updatePassword(changePassObj, success: { _ in
                            
                        }, failure: { _ in
                            
                        })
                       
                    }).padding(.top)
                }.padding(.vertical,30)
                Spacer()
                HStack{
                    
                    
                    Text("Terms and Conditions")
                        .underline()
                        .fontWeight(.regular)
                        .font(.system(size: 12))
                        .foregroundColor(Color("fontBlue"))
                        .onTapGesture {
                            viewRouter.currentPage = "SignUpScreen"
                        }
                }.padding(.vertical,20)

            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .ignoresSafeArea(.all)
            .background(Color("appbg"))
    }
}

struct ChangePasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordScreen()
    }
}
