//
//  LoadingView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import SwiftUI
import UIKit

struct ActivityIndicatorView: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .darkGreen
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
}

struct LoadingView: View {
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea(edges: .all)
            
            ActivityIndicatorView()
        }
    }
}
