//
//  NotificationScreen.swift
//  Khebra
//
//  Created by Sheheryar on 04/09/2022.
//

import SwiftUI

struct NotificationScreen: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var notifications: [NotificationObjectElement] = []
    var body: some View {
        ZStack{
            VStack{
                TopNavigation(titleText: "Notifications")
                ScrollView{
                    ForEach(0 ..< notifications.count,id:\.self) { ind in
                        NotificationCard(text: notifications[ind].descripton ?? "")
                    }
                    
                }
                BottomNavTechnician()
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .ignoresSafeArea(.all)
            .background(Color("appbg"))
            .task {
                technicianApi.getNotifications(orderId: "", success: { res in
                    notifications = res
                }, failure: { _ in
                    
                })
            }
    }
}

struct NotificationScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotificationScreen()
    }
}
