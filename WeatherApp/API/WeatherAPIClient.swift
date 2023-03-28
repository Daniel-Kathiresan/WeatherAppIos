//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Daniel Kathiresan on 28/3/2023.
//

import Foundation
import CoreLocation

final class WeatherAPIClient: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var currentWeather: Weather?
    
    private let locationManager = CLLocationManager()
    private let dateFormatter = ISO8601DateFormatter()

    
    override init() {
        super.init()
        locationManager.delegate = self
        requestLocation()
    }
    
    func fetchWeather() async {
        guard let location = locationManager.location else {
            requestLocation()
            return
        }
        
        guard let url = URL(string: "https://api.tomorrow.io/v4/timelines?location=\(location.coordinate.latitude),\(location.coordinate.longitude)&fields=temperature&fields=weatherCode&units=metric&timesteps=1h&startTime=\(dateFormatter.string(from: Date()))&endTime=\(dateFormatter.string(from: Date().addingTimeInterval(60 * 60)))&apikey={api-key-here}") else {
                    return
                }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let weatherResponse = try? JSONDecoder().decode(WeatherModel.self, from: data),
                let weatherValue = weatherResponse.data.timelines.first?.intervals.first?.values,
                let weatherCode = WeatherCode(rawValue: "\(weatherValue.weatherCode)") {
                    DispatchQueue.main.async { [weak self] in
                       self?.currentWeather = Weather(temperature: Int(weatherValue.temperature),
                                                      weatherCode: weatherCode)
                    }
            }
        } catch {
            //Error handling
        }
    }
    
    private func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task { await fetchWeather() }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //handle the error
    }
    
    struct Weather: Identifiable {
        let id = UUID()
        
        let temperature: Int
        let weatherCode: WeatherCode
    }
}
