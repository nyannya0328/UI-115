//
//  HomeViewModel.swift
//  UI-115
//
//  Created by にゃんにゃん丸 on 2021/01/31.
//

import SwiftUI
import UserNotifications

class HomeViewModel: NSObject,UNUserNotificationCenterDelegate, ObservableObject {
    
    @Published var time : Int = 0
    @Published var selectedtime : Int = 0
    @Published var buttonAnimation = false
    
    @Published var timerViewOffset : CGFloat = UIScreen.main.bounds.height
    @Published var HeigthChange : CGFloat = 0
    
    @Published var lefttime : Date = Date()
    
    @Published var text = ""
    @Published var numbercount = 0
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        completionHandler()
        
    }
    
    
    func ResetView(){
        
        time = 0
        selectedtime = 0
        timerViewOffset = UIScreen.main.bounds.height
        HeigthChange = 0
        buttonAnimation = false
    }
    func perfomNotifications(){
        
        
        let content = UNMutableNotificationContent()
        content.title = "From Kavsfor"
        content.body = "Timer has been finished"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(time), repeats: false)
        
        let request = UNNotificationRequest(identifier: "Timer", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (err) in
            if err != nil{
                
                print(err!.localizedDescription)
            }
        }
        
        
    }
    
    func generateCard(){
        
        let number = text.replacingOccurrences(of: "-", with: "")
        
        if (number.count) % 4  == 0 && !number.isEmpty{
            
            if !String(text.last!).elementsEqual("-"){
                
                text.append("-")
                
            }
            
            
        }
        
       
        
       
        
       
        
        
        
    }
    
    func removecard(){
        
        let number = text.replacingOccurrences(of: "", with: "")
        
        if (number.count) % 15  == 0 && !number.isEmpty{
            
            if !String(text.last!).elementsEqual(""){
                
                text.removeLast()
            
            
        }
        
        
        
    }
    
   
    
    
    
}

}
