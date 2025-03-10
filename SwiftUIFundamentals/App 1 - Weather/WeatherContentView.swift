//
//  WeatherContentView.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 1/3/2568 BE.
//

import SwiftUI

struct WeatherContentView: View {
    
    @State private var isNight: Bool = false
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            VStack {
                CityTextView(cityName: "Cupertino, CA")
                
                TodayWeatherView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", termperature: "76°")
                
                HStack(spacing: 16.0) {
                    WeatherDayView(dayOfWeek: "S", imageName: "cloud.sun.fill", termperature: "76°")
                    
                    WeatherDayView(dayOfWeek: "M", imageName: "cloud.sun.bolt.fill", termperature: "76°")
                    
                    WeatherDayView(dayOfWeek: "T", imageName: "cloud.sun.rain.fill", termperature: "76°")
                    
                    WeatherDayView(dayOfWeek: "W", imageName: "cloud.sun.fill", termperature: "76°")
                    
                    WeatherDayView(dayOfWeek: "F", imageName: "cloud.sun.bolt.fill", termperature: "76°")
                    
                    WeatherDayView(dayOfWeek: "S", imageName: "cloud.sun.rain.fill", termperature: "76°")
                }
                
                Spacer()
                
                PrimaryButtonStyleView(
                    textTitle: "Change Day Time",
                    textColor: .white,
                    backgroundColor: Color.mint, tapAction: {
                        isNight.toggle()
                    })
                Spacer()
            }
        }
        .onAppear {
            print("Hello Weather")
        }
    }
}

#Preview {
    WeatherContentView()
}

// MARK: Background
struct BackgroundView: View {
    
    @Binding var isNight: Bool
    
    var body: some View {
       /*
        LinearGradient(
            gradient: Gradient(
                colors: [isNight ? .black : .blue, isNight ? .gray : .lightBlue]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
        .ignoresSafeArea(.all)
        */
        ContainerRelativeShape()
            .fill(isNight ? Color.black.gradient : Color.blue.gradient)
            .ignoresSafeArea()
    }
}

// MARK: City Name
struct CityTextView: View {
    
    var cityName: String
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium))
            .foregroundStyle(.white)
            .padding()
    }
}

/*
 Use in only WeatherContentView
 */

// MARK: To day weather
struct TodayWeatherView: View {
    
    var imageName: String
    var termperature: String
    
    var body: some View {
        VStack(spacing: 8.0) {
            Image(systemName: imageName).renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
            
            Text(termperature)
                .font(.system(size: 70, weight: .medium))
                .foregroundStyle(.white)
        }
        .padding(.bottom, 32.0)
    }
}


// MARK: List Wather
struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var termperature: String
    
    var body: some View {
        VStack(spacing: 4.0) {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white)
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
//                .foregroundStyle(.indigo, .pink, .red)
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            
            Text(termperature)
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(.white)
        }
    }
}

