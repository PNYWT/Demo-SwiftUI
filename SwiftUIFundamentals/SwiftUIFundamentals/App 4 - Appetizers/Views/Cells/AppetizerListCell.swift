//
//  AppetizerListCell.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import SwiftUI

struct AppetizerListCell: View {
    
    let appetizer: AppetizerModel
    
    var body: some View {
        HStack {
            AsyncImageView(urlString: appetizer.imageURL)
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 90)
                .cornerRadius(8)
            /*
             AppetizerRemoteImage(urlString: appetizer.imageURL)
                 .aspectRatio(contentMode: .fit)
                 .frame(width: 120, height: 90)
                 .cornerRadius(8)
             
             AsyncImage(url: URL(string: appetizer.imageURL), transaction: Transaction(animation: .easeInOut)) { phase in
                 switch phase {
                 case .empty:
             LoadingView()
                 case .success(let image):
                     image
                         .resizable()
                 default:
                     Image(.foodPlaceholder)
                         .resizable()
                 }
             }
             .aspectRatio(contentMode: .fit)
             .frame(width: 120, height: 90)
             .cornerRadius(8)
             */
                
            
            VStack(alignment: .leading, spacing: 4.0) {
                Text(appetizer.name)
                    .font(.title2)
                    .fontWeight(.medium)
                Text("$\(appetizer.price, specifier: "%.2f")")
                    .foregroundStyle(.secondary)
                    .fontWeight(.semibold)
            }
            .padding(8)
        }
    }
}


#Preview {
    AppetizerListCell(appetizer: MockDataAppetizer.sampleAppetizer)
}
