//
//  ContentView.swift
//  FirstWatchApp Watch App
//
//  Created by Karl Mellinger on 12/27/23.
//

import SwiftUI
import WatchKit
import SwiftUI_Apple_Watch_Decimal_Pad

struct ContentView: View {
    @State private var timerActive = false
    @State private var timeRemaining = 30 * 60 // 30 minutes in seconds
    @State private var tallyCount = 0 // Tally count
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Drink Count: \(String(tallyCount))")
                    .font(.system(size:24))
                    .padding()
                
                Button(action: {
                    self.startTimer()
                }) {
                    Image(timerActive ? "StopClock" : "Cocktail")
                        .resizable()
                        .frame(width: 75, height: 75)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .buttonStyle(PlainButtonStyle())
                .padding()
                
                if timerActive {
                    Text("\(timeString(time: timeRemaining))")
                        .font(.title2)
                        .onReceive(timer) { _ in
                            if self.timeRemaining > 0 {
                                self.timeRemaining -= 1
                            } else {
                                self.timerActive = false
                                self.triggerHapticFeedback()
                            }
                        }
                    
                }
                else {
                    // Navigation link to ResetCountView
                    NavigationLink(destination: ResetCountView(tallyCount: $tallyCount)) {
                        Text("Reset Tally")
                    }
                    .padding()
                    
                }
            }
        }
    }
        
        func startTimer() {
            if timerActive {
                timerActive = false
            } else {
                timeRemaining = 30 * 60
                timerActive = true
                tallyCount += 1
            }
        }
        
        func timeString(time: Int) -> String {
            let hours = Int(time) / 3600
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        }
        
        func triggerHapticFeedback() {
            WKInterfaceDevice.current().play(.success)
        }
    }
struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
