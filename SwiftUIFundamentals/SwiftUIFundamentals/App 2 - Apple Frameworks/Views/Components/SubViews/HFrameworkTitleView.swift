//
//  HFrameworkTitleView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 9/3/2568 BE.
//

import SwiftUI

struct HFrameworkTitleView: View {
    
    let frameworkModel: FrameworkModel
    
    var body: some View {
        HStack {
            Image(frameworkModel.imageName)
                .resizable()
                .frame(width: 70, height: 70)
            Text(frameworkModel.name)
                .font(.title2)
                .fontWeight(.semibold)
                .scaledToFit()
                .minimumScaleFactor(0.6)
                .padding()
        }
    }
}

#Preview {
    HFrameworkTitleView(frameworkModel: MockData.sampleFramework)
}
