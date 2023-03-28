//
//  ContentView.swift
//  WeatherApp
//
//  Created by Daniel Kathiresan on 28/3/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var weatherAPIClient = WeatherAPIClient()
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Spacer()
            if let currentWeather = weatherAPIClient.currentWeather  {
                            HStack(alignment: .center, spacing: 16) {
                                currentWeather.weatherCode.image
                                    .font(.largeTitle)
                                Text("\(currentWeather.temperature)º")
                                    .font(.largeTitle)
                            }
                            Text(currentWeather.weatherCode.description)
                                .font(.body)
                                .multilineTextAlignment(.center)
                        } else {
                Text("No weather info available yet.\n Tap on refresh to fetch new data")
                    .font(.body)
                    .multilineTextAlignment(.center)
                Button("Refresh", action: {
                    Task {
                        await weatherAPIClient.fetchWeather()
                    }
                })
            }
            
            Spacer()
        }
        .onAppear {
            Task {
                await weatherAPIClient.fetchWeather()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
