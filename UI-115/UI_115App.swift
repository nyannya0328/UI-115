//
//  UI_115App.swift
//  UI-115
//
//  Created by にゃんにゃん丸 on 2021/01/31.
//

import SwiftUI

@main
struct UI_115App: App {
    
    @StateObject var model = HomeViewModel()
    @Environment(\.scenePhase) var phase
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
        .onChange(of: phase) { (newsence) in
            if newsence == .background{
                
                model.lefttime = Date()
                
                
                
            }
            if newsence == .active && model.time != 0{
                
                let diff = Date().timeIntervalSince(model.lefttime)
                let carrenttime = model.selectedtime - Int(diff)
                if carrenttime >= 0{
                    
                    withAnimation(.default){
                        
                        model.selectedtime = carrenttime
                    }
                }
                
                else{
                    
                    model.ResetView()
                }
            
            }
        }
    }
}
