//
//  FrameworkTitleView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 9/3/2568 BE.
//

import SwiftUI

struct VFrameworkTitleView: View {
    
    let frameworkModel: FrameworkModel
    
    var body: some View {
        VStack {
            Image(frameworkModel.imageName)
                .resizable()
                .frame(width: 90, height: 90)
            Text(frameworkModel.name)
                .font(.title2)
                .fontWeight(.semibold)
                .scaledToFit()
                .minimumScaleFactor(0.6)
        }
        .padding()
    }
}

#Preview {
    VFrameworkTitleView(frameworkModel: MockData.sampleFramework)
}
