//
//  Home.swift
//  UI-115
//
//  Created by にゃんにゃん丸 on 2021/01/31.
//

import SwiftUI
import UserNotifications

let gra = LinearGradient(gradient: .init(colors: [.red,.purple]), startPoint: .bottomTrailing, endPoint: .topTrailing)

let gra1 = LinearGradient(gradient: .init(colors: [.orange,.red]), startPoint: .top, endPoint: .bottom)

struct Home: View {
    @EnvironmentObject var model : HomeViewModel
    var body: some View {
        
        ZStack{
            VStack(spacing:0){
                
                Spacer()
                
                
                VStack(spacing:15){
                    
                    Text("クレジット")
                        .padding(.bottom,5)
                    
                    Divider()
                    
                    TextField("Enter Creadit Number", text: $model.text)
                        .keyboardType(.numberPad)
                   
                        
                   
               
                }
                .padding(.leading)
                .background(
                    RoundedRectangle(cornerRadius: 6).stroke(Color.gray,lineWidth: 2)
                )
                
               
              
                
                
                
              
                .onChange(of: model.text, perform: { value in
                    
                    model.generateCard()
                    model.removecard()
                   
                    
                })
            
                
                
            
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    
                    HStack{
                        
                        ForEach(1...6,id:\.self){index in
                            
                            let time = index * 5
                            
                          Text("\(time)")
                            .font(.system(size: 45, weight: .heavy))
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                            .background(model.time == time ? gra : gra1)
                            .clipShape(Circle())
                            .onTapGesture {
                                withAnimation(.linear){
                                    
                                    model.time = time
                                    model.selectedtime = time
                                    
                                }
                            }
                            
                            
                           
                            
                            
                        }
                    }
                  
                    .padding(.horizontal)
                    
                   
                    
                })
                .offset(y: 40)
                .opacity(model.buttonAnimation ? 0 : 1)
                
                Spacer()
                
                Button(action: {
                    
                    withAnimation(Animation.easeOut(duration: 0.6)){
                        
                        model.buttonAnimation.toggle()
                        
                        
                        
                    }
                    withAnimation(Animation.easeIn(duration: 0.6)){
                        
                        model.timerViewOffset = 0
                    }
                    
                    model.perfomNotifications()
                    
                    
                }, label: {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 80, height: 80)
                        
                })
                .padding(.bottom,30)
                .disabled(model.time == 0)
                .opacity(model.time == 0 ? 0.5 : 1)
                .offset(y: model.buttonAnimation ? 300 : 0)
                
                
                
            }
            
            Color.purple
                .overlay(
                    
                    Text("\(model.selectedtime)")
                        .font(.system(size: 60, weight: .heavy))
                       
                        .foregroundColor(.white)
                    
                
                
                )
                .frame(height: UIScreen.main.bounds.height - model.HeigthChange)
                .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea(.all, edges: .all)
                .offset(y: model.timerViewOffset)
           
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.3).ignoresSafeArea(.all, edges: .all))
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect(), perform: { _ in
            
            if model.time != 0 && model.selectedtime != 0 && model.buttonAnimation{
                
                model.selectedtime -= 1
                
                let progress = UIScreen.main.bounds.height / CGFloat(model.time)
                let diff = model.time - model.selectedtime
                withAnimation(.default){
                    
                    model.HeigthChange = CGFloat(diff) * progress
                }
                
                if model.selectedtime == 0{
                    
                    model.ResetView()
                }
                
                
            }
            
        })
        .onAppear(perform: {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (_, _) in
                
            }
            
            UNUserNotificationCenter.current().delegate = model
           
            
        })
       
       
    }
    
    
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
