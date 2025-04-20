//
//  SeekrTwoView.swift
//  Seekr
//
//  Created by Darius Ehsani on 4/19/25.
//

import SwiftUI

struct SeekrTwoView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var progressModel: ProgressModel

    var body: some View {
        
        VStack(alignment: .leading) {
            
            // Start Button Function
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image("ic-back")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                        .padding(.leading, 16)
                }
                Spacer()
            }
            .padding(.top, 40)
            
            // End Button Function
            
            // Image Display Start
            Image("ic-img2")
                .resizable()
                .padding(.top, 10)
                .aspectRatio(contentMode: .fit)
                .frame(width: 377, height: 377)
                .frame(maxWidth: .infinity, alignment: .center)
            // Image Display End
            
            // Riddle Display Start
            Image("ic-desc2")
                .resizable()
                .padding(.top, 15)
                .aspectRatio(contentMode: .fit)
                .frame(width: 396, height: 201)
                .frame(maxWidth: .infinity, alignment: .center)

            Spacer()
            // Riddle Display End
            
            
            // Camera Function Start
            
            HStack {
                Spacer()
                NavigationLink(destination: MapView(progressModel: progressModel).environmentObject(progressModel)) {
                    Image("ic-userMap")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 96, height: 96)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    //progressModel.lat = 38.538611
                    //progressModel.lon = -121.752778
                    
                    
                    // SF Test
                    progressModel.lat = 37.7877
                    progressModel.lon = -122.4084
                    
                })
                Spacer()
            }
            .padding(.bottom, 30)
            
            // Camera Function End
            
        }
        
        .navigationBarBackButtonHidden(true)

    }
}

#Preview {
    SeekrTwoView()
}
