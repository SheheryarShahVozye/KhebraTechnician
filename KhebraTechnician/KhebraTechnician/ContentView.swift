//
//  ContentView.swift
//  KhebraTechnician
//
//  Created by Sheheryar on 24/10/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        
        if viewRouter.currentPage == "splashscreen" {
            SplashScreen()
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        viewRouter.currentPage = "LoginScreen"
                    }
                })
        } else {
            RouteManager()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct RouteManager: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        if viewRouter.currentPage == "LoginScreen" {
            LoginScreen()
        } else if viewRouter.currentPage == "SignUpScreen" {
            SignUpScreen()
        } else if viewRouter.currentPage == "VerificationScreen" {
            VerificationScreen()
        } else if viewRouter.currentPage == "AccountCompletion" {
            AccountCompletion()
        }  else if viewRouter.currentPage == "TechnicianDashboard" {
            TechnicianDashboard()
        } else if viewRouter.currentPage == "NotificationScreen" {
            NotificationScreen()
        } else if viewRouter.currentPage == "OrderDashboardScreen" {
            OrderDashboardScreen()
        } else if viewRouter.currentPage == "NewOrderDetailScreen" {
            NewOrderDetailScreen()
        } else if viewRouter.currentPage == "IncomingOrderScreen" {
            IncomingOrderScreen()
        } else if viewRouter.currentPage == "DeferredOrderScreen" {
            DeferredOrderScreen()
        } else if viewRouter.currentPage == "CompletedOrderScreen" {
            CompletedOrderScreen()
        } else if viewRouter.currentPage == "InvoiceDetailScreen" {
            InvoiceDetailScreen()
        } else if viewRouter.currentPage == "TechMoreScreen" {
            TechMoreScreen()
        } else if viewRouter.currentPage == "IncomeScreen" {
            IncomeScreen()
        } else if viewRouter.currentPage == "HowToUseScreen" {
            HowToUseScreen()
        } else if viewRouter.currentPage == "TechProfileScreen" {
            TechProfileScreen()
        } else if viewRouter.currentPage == "SettingScreen" {
            SettingScreen()
        } else if viewRouter.currentPage == "RegisterPasswordScreen" {
            RegisterPasswordScreen()
        } else if viewRouter.currentPage == "IncentivePenaltyScreen" {
            IncentivePenaltyScreen()
        } else if viewRouter.currentPage == "NewInvoiceScreen" {
            NewInvoiceScreen()
        } else if viewRouter.currentPage == "RatingFactorScreen" {
            RatingFactorScreen()
        }
//        else if viewRouter.currentPage == "ChooseOnMapScreen" {
//            ChooseOnMapScreen()
//        }
        
    }
    
    
}
