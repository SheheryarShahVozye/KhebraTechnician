//
//  ApplicationCompleteScreen.swift
//  KhebraTechnician
//
//  Created by apple on 12/11/2022.
//

import SwiftUI

struct ApplicationCompleteScreen: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        ZStack{
            VStack{
                Text("Applied Successfully")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(Color("fontBlue"))
                
                Text("You have successfully applied for the Order. The customer will get in touch")
                    .font(.system(size: 15))
                    .foregroundColor(Color("lightgray"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top)
                
                
                OrderButton(title: "Done", callback: {
                    viewRouter.currentPage = "TechnicianDashboard"
                })
                
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .ignoresSafeArea(.all)
            .background(Color("appbg"))
    }
}

struct ApplicationCompleteScreen_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationCompleteScreen()
    }
}
