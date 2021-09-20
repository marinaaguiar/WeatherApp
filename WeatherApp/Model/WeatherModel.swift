//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Marina Aguiar on 8/4/21.
//

import UIKit

struct WeatherModel {
    
    var weatherManager = WeatherManager()
    
    let cityName: String
    let countryName: String
    let currentTemperature: Double
    let currentTime: String
    let sunriseTime: String
    let sunsetTime: String
    let currentDate: String
    let conditionId: Int
    let conditionDescription: String
    let isDay: Bool
    
    var temperature: String {
        return String(format: "%.0f°C", currentTemperature)
    }
    
    var currentTimeAmPm: String? {
        guard let currentTimeAmPm = converToAmPm(from: currentTime) else {
            return nil
        }
        return currentTimeAmPm
    }

    
    var conditionName: String {
        
        var condition: String
        
        switch conditionId {
        case 200...232:
            condition = "thunderstorm"
        case 300...321:
            condition = "drizzle"
        case 500...531:
            condition = "rain"
        case 600...622:
            condition = "snow"
        case 701...781:
            condition = "fog"
        case 800:
            condition = "clear sky"
        case 801...802:
            condition = "few clouds"
        case 803...804:
            condition = "clouds"
        default:
            condition = "cloud"
        }
        
        condition += isDay ? ".day" : ".night"
        
        return condition
    }
    
    var backgroundColor: UIColor {
            switch conditionName {
            case "thunderstorm.day", "thunderstrom.night":
                return UIColor(red: 0.59, green: 0.58, blue: 0.58, alpha: 1.00)
            case "drizzle.day", "drizzle.night":
                return UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00)
            case "snow.day", "snow.night":
                return UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00)
            case "fog.day", "fog.night":
                return UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00)
            case "clear sky.day", "few clouds.day", "rain.day":
                return UIColor(red: 1.00, green: 0.98, blue: 0.86, alpha: 1.00)
            case "clear sky.night", "few clouds.night", "rain.night":
                return UIColor(red: 0.47, green: 0.64, blue: 0.73, alpha: 1.00)
            case "clouds.day","clouds.night":
            return UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00)
        
            default:
                return UIColor.systemTeal
        }
    }
    
    var darkOrLightMode: UIUserInterfaceStyle {
            switch conditionName {
            case "thunderstorm.day", "thunderstrom.night", "clear sky.day", "snow.day", "snow.night", "drizzle.day", "drizzle.night", "fog.day", "fog.night", "few clouds.day", "rain.day", "clouds.day","clouds.night":
                return .light
            case "clear sky.night", "few clouds.night", "rain.night":
                return .dark
                
            default:
                return .light
        }
    }
    
    
    
    var promptTextMessage: String {
        switch conditionName {
        case "thunderstorm.day", "thunderstrom.night":
            return "stay safe!"
        case "drizzle.day", "drizzle.night":
            return "it's just a drizzle!"
        case "rain.day", "rain.night":
            return "you better have an umbrella!"
        case "snow.day", "snow.night":
            return "don't forget your coat!"
        case "fog.day", "fog.night":
            return "don't worry this fog will pass!"
        case "clear sky.day":
            return "have a bright day!"
        case "clear sky.night":
            return "nighty night!"
        case "few clouds.day", "few clouds.night", "clouds.day", "clouds.night", "cloud.day", "cloud.night":
            return "don't worry this cloud will pass!"
        default:
            return ""
            
        }
    }
    
    
    // Converter os dados em miliseconds para o formato de hora padrão
    
    private func convert(from timeInMilliseconds: Int, timeZoneInMilliseconds: Int) -> String? {
        guard let timeZone = TimeZone(secondsFromGMT: timeZoneInMilliseconds) else {
            return nil
        }
        
        let date = Date(timeIntervalSince1970: Double(timeInMilliseconds))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "HH:mm"
        
        
        return dateFormatter.string(from: date)
    }
    
    private func converToAmPm(from currentTime: String?) -> String? {
        let inFormatter = DateFormatter()
        inFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        inFormatter.dateFormat = "HH:mm"
        
        let outFormatter = DateFormatter()
        outFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        outFormatter.dateFormat = "h:mm a"
        
        guard let inStr = currentTime else {
            return nil
        }
        guard let date = inFormatter.date(from: inStr) else {
            return nil
        }
        
        return outFormatter.string(from: date) // -> outputs 04:50
    }
    
    

    
}

