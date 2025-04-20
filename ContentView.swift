//
//  ContentView.swift
//  Seekr
//
//  Created by Darius Ehsani on 4/19/25.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var progressModel: ProgressModel
    
    @State private var isActiveSeekrOne = false
    @State private var isActiveSeekrTwo = false
    @State private var isActiveSeekrThree = false
    @State private var isActiveSeekrFour = false

    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Navigation to Riddles
                Text("Seekr #1")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 326, maxHeight: 109)
                    .background(Color.indigo)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.accentColor, lineWidth: 2)
                    )
                
                    .opacity(progressModel.isOneUnlocked ? 1.0 : 0.5)
                    .onTapGesture {
                        if progressModel.isOneUnlocked {
                            isActiveSeekrOne = true
                        }
                    }
                    .navigationDestination(isPresented: $isActiveSeekrOne) {
                        SeekrOneView()
                    }
                
                Text("Seekr #2")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 326, maxHeight: 109)
                    .background(Color.indigo)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.accentColor, lineWidth: 2)
                    )
                
                    .opacity(progressModel.isTwoUnlocked ? 1.0 : 0.5)
                    .onTapGesture {
                        if progressModel.isTwoUnlocked {
                            isActiveSeekrTwo = true
                        }
                    }
                    .navigationDestination(isPresented: $isActiveSeekrTwo) {
                        SeekrTwoView()
                    }
                
                Text("Seekr #3")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 326, maxHeight: 109)
                    .background(Color.indigo)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.accentColor, lineWidth: 2)
                    )
                
                    .opacity(progressModel.isThreeUnlocked ? 1.0 : 0.5)
                    .onTapGesture {
                        if progressModel.isThreeUnlocked {
                            isActiveSeekrThree = true
                        }
                    }
                    .navigationDestination(isPresented: $isActiveSeekrThree) {
                        SeekrThreeView()
                    }
                
                Text("Seekr #4")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 326, maxHeight: 109)
                    .background(Color.indigo)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.accentColor, lineWidth: 2)
                    )
                
                    .opacity(progressModel.isFourUnlocked ? 1.0 : 0.5)
                    .onTapGesture {
                        if progressModel.isFourUnlocked {
                            isActiveSeekrFour = true
                        }
                    }
                    .navigationDestination(isPresented: $isActiveSeekrFour) {
                        SeekrFourView()
                    }

            }
            .onAppear {
                // Keep progress as-is to reflect true progression from FoundView
            }
            .padding()
        }
        
        
        .overlay(
            VStack {
                ProgressView(value: progressModel.progress)
                    .progressViewStyle(LinearProgressViewStyle())
                    .accentColor(.green)
                    .frame(height: 10)
                    .padding(.horizontal)
                    .padding(.top)
                Spacer()
            },
            alignment: .top
        )
    }
}

#Preview {
    ContentView()
}
