//
//  CompleteView.swift
//  Seekr
//
//  Created by Darius Ehsani on 4/20/25.
//

import SwiftUI

struct CompleteView: View {

    var body: some View {
        ZStack {
            Image("ic-congrats")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 407, height: 713)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 10)
        }
        
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CompleteView()
}
