//
//  AppertizerDetailView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 11/3/2568 BE.
//

import SwiftUI

struct AppertizerDetailView: View {
    
    @EnvironmentObject var orderViewModel: OrderViewModel
    
    let appertizer: AppetizerModel
    @Binding var isShowingDetail: Bool
    
    var body: some View {
        VStack {
            AppetizerRemoteImage(urlString: appertizer.imageURL)
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 225)
            
            VStack {
                Text(appertizer.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(appertizer.description)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding()
                
                HStack(spacing: 40) {
                    NutritionInfoView(title: "Calories", value: appertizer.calories.codingKey.stringValue)
                    
                    NutritionInfoView(title: "Carbs", value: appertizer.carbs.codingKey.stringValue)
                    
                    NutritionInfoView(title: "Protein", value: appertizer.protein.codingKey.stringValue)
                }
            }
            
            Spacer()
            
            Button {
                print("Tab")
                orderViewModel.addItem(appertizer)
                isShowingDetail = false
            } label: {
                PrimaryCartButton(price: appertizer.price, title: "Add to Order")
            }
            .padding(.bottom, 30)
        }
        .frame(width: 300, height: 525)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 20, x: 15)
        .overlay(alignment: .topTrailing) {
            Button {
                isShowingDetail = false
            } label: {
                PrimaryXButton()
            }
        }
    }
}

#Preview {
    AppertizerDetailView(appertizer: MockDataAppetizer.sampleAppetizer, isShowingDetail: .constant(true))
}

struct NutritionInfoView: View {
    
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .bold()
                .font(.caption)
            
            Text(value)
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
                .italic()
        }
    }
}
