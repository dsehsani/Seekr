//
//  LocationFound.swift
//  Seekr
//
//  Created by Darius Ehsani on 4/19/25.
//

import SwiftUI

struct FoundView: View {
    @EnvironmentObject var progressModel: ProgressModel
    @Environment(\.dismiss) var dismiss
    @State private var goToContent = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Image("ic-didIt") // Replace with actual asset name
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 375, height: 247)
                        .padding()
                    
                    Image("ic-descFound") // Replace with your actual second asset name
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 365, height: 170)
                        .padding(.top, 16)
                    
                    Button(action: {
                        if !progressModel.isTwoUnlocked && progressModel.isOneUnlocked {
                            progressModel.isTwoUnlocked = true
                            progressModel.isOneUnlocked = false
                        } else if !progressModel.isThreeUnlocked && progressModel.isTwoUnlocked {
                            progressModel.isThreeUnlocked = true
                            progressModel.isTwoUnlocked = false
                        } else if !progressModel.isFourUnlocked && progressModel.isThreeUnlocked {
                            progressModel.isFourUnlocked = true
                            progressModel.isThreeUnlocked = false
                        }

                        goToContent = true
                    }) {
                        Image("ic-unlock") // Replace with the actual asset name for your button image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 277, height: 81)
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .onAppear {
                    if progressModel.progress < 1.0 {
                        progressModel.progress += 0.25
                    }
                }
                
                NavigationLink(destination: ContentView(), isActive: $goToContent) {
                    EmptyView()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    FoundView()
}
