//
//  ResetCountView.swift
//  FirstWatchApp Watch App
//
//  Created by Karl Mellinger on 1/2/24.
//

import SwiftUI
import SwiftUI_Apple_Watch_Decimal_Pad

struct ResetCountView: View {
    @Binding var tallyCount: Int
    @State private var passwordInput: String = ""
    @State private var isUnlocked: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            if isUnlocked {
                Button("Reset Count") {
                    tallyCount = 0
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(10)
            } else {
                TextField("Enter Password", text: $passwordInput)
                    .padding()
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(5)
                Button("Unlock") {
                    // Replace "your_password" with your actual password
                    isUnlocked = passwordInput == "mellinka"
                }
                .padding()
            }
        }
        .padding()
    }
}
