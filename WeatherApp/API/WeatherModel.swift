//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Daniel Kathiresan on 28/3/2023.
//

import Foundation
import SwiftUI

struct WeatherModel: Codable {
    let data: WeatherData
}

struct WeatherData: Codable {
    let timelines: [WeatherTimelines]
}

struct WeatherTimelines: Codable {
    let intervals: [WeatherIntervals]
}

struct WeatherIntervals: Codable {
    let startTime: String
    let values: WeatherValue
}

struct WeatherValue: Codable {
    var temperature: Double
    var weatherCode: Int
}

struct Weather: Identifiable {
    let id = UUID()
    
    let temperature: Int
    let weatherCode: WeatherCode
}

enum WeatherCode: String, Codable {
    case clear = "1000"
    case mostlyClear = "1100"
    case partlyCloudy = "1101"
    case mostlyCloudy = "1102"
    case cloudy = "1001"
    case fog = "2000"
    case lightFog = "2100"
    case lightWind = "3000"
    case wind = "3001"
    case strongWind = "3002"
    case drizzle = "4000"
    case rain = "4001"
    case lightRain = "4200"
    case heavyRain = "4201"
    case snow = "5000"
    case flurries = "5001"
    case lightSnow = "5100"
    case heavySnow = "5101"
    case freezingDrizzle = "6000"
    case freezingRain = "6001"
    case lightFreezingRain = "6200"
    case heavyFreezingRain = "6201"
    case icePellets = "7000"
    case heavyIcePellets = "7101"
    case lightIcePellets = "7102"
    case thunderstorm = "8000"
    
    var description: String {
        switch self {
        case .clear:
            return "It's very sunny!\n Don't forget your gat!"
        case .cloudy, .mostlyCloudy:
            return "Cloudy today"
        case .mostlyClear, .partlyCloudy:
            return "Enjoy your day!"
        case .fog, .lightFog:
            return "Drive safe and make sure to turn off your headlights!"
        case .lightWind:
            return "Enjoy some light breeze today!"
        case .wind, .strongWind:
            return "Get your parachute out!"
        case .drizzle, .lightRain:
            return "Toughen up who needs an umbrella"
        case .rain, .heavyRain:
            return "Time for some skids! Get driving"
        case .snow, .flurries, .lightSnow, .heavySnow:
            return "Fun fact: adding a brick to a snowball makes it \n travel further!"
        case .freezingDrizzle:
            return "Did you know drinking heavy amounts of liquor \n keeps you warm?"
        case .freezingRain, .lightFreezingRain, .heavyFreezingRain:
            return "Just stay home its not worth it"
        case .icePellets:
            return "Ice Pellets: Potential to die"
        case .heavyIcePellets:
            return "Hail! Go outside and open your mouth"
        case .lightIcePellets:
            return "Light Ice Pellets: Still potential death"
        case .thunderstorm:
            return "Thunderstorm! \n Go stand outside with a golf club"
        }
    }
    
    var image: Image {
        switch self {
        case .clear:
            return Image(systemName: "sun.max.fill")
        case .cloudy:
            return Image(systemName: "cloud.fill")
        case .mostlyClear, .partlyCloudy, .mostlyCloudy:
            return Image(systemName: "cloud.sun.fill")
        case .fog, .lightFog:
            return Image(systemName: "cloud.fog.fill")
        case .lightWind, .wind:
            return Image(systemName: "wind")
        case .strongWind:
            return Image(systemName: "tornado")
        case .drizzle:
            return Image(systemName: "cloud.drizzle.fill")
        case .lightRain, .rain:
            return Image(systemName: "cloud.rain.fill")
        case .heavyRain:
            return Image(systemName: "cloud.heavyrain.fill")
        case .snow, .flurries, .lightSnow, .heavySnow:
            return Image(systemName: "snow")
        case .freezingDrizzle:
            return Image(systemName: "thermometer.snowflake")
        case .freezingRain, .lightFreezingRain, .heavyFreezingRain:
            return Image(systemName: "cloud.rain.fill")
        case .icePellets, .heavyIcePellets, .lightIcePellets:
            return Image(systemName: "cloud.hail.fill")
        case .thunderstorm:
            return Image(systemName: "cloud.bolt.fill")
        }
    }
}
