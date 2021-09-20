////
////  WeatherManager.swift
////  WeatherApp
////
////  Created by Marina Aguiar on 7/30/21.
////
//
//import Foundation
//import CoreLocation
//
//
//struct WeatherManager {
//
//    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=08219b31e296bc3cfc1ece990074fa5f&units=metric"
//
//
//    func performRequest(with urlString: String) {
//
//    //MARK: 1. Create a URL
//        guard let url = URL(string: urlString) else {
//            abort()
//        }
//
//    //MARK: 2. Create a URLSession
//        let session = URLSession(configuration: .default)
//
//    //MARK: 3. Give the session a task
//        let task = session.dataTask(with: url, completionHandler: handleRequestData)
//
//    // MARK: 4. Start the task
//        task.resume()
//    }
//
//    func handleRequestData(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
//        if error != nil {
//            print(error!)
//            return
//        }
//
//        if let safeData = data {
//            if let weather = self.parseJSON(safeData) {
//                delegate?.didUpdateWeather(self, weather: weather)
//            }
//        }
//    }
//
//    // MARK: - parseJSON
//
//    func parseJSON(_ weatherData: Data) -> WeatherModel? {
//
//        let decoder = JSONDecoder()
//
//        do {
//            let decoded = try decoder.decode(WeatherData.self, from: weatherData)
//
//            // MARK:  Extract API data
//
//            let cityName = decoded.name
//            let currentTemperature = decoded.main.temp
//            let currentTimeInMilliseconds = decoded.dt
//            let timeZoneInMilliseconds = decoded.timezone
//            let sunriseInMilliseconds = decoded.sys.sunrise
//            let sunsetInMilliseconds = decoded.sys.sunset
//
//            // MARK: Extract the values of standard date format
//
//            guard let currentTime: String = convert(from: currentTimeInMilliseconds, timeZoneInMillisseconds: timeZoneInMilliseconds) else {
//                abort()
//            }
//
//            guard let sunriseTime: String = convert(from: sunriseInMilliseconds, timeZoneInMillisseconds: timeZoneInMilliseconds) else {
//                abort()
//            }
//
//            guard let sunsetTime: String = convert(from: sunsetInMilliseconds, timeZoneInMillisseconds: timeZoneInMilliseconds) else {
//                abort()
//            }
//
//            guard let currentDate: String = convertToCurrentDate(from: currentTimeInMilliseconds, timeZoneInMillisseconds: timeZoneInMilliseconds) else {
//                abort()
//            }
//
//
//            // MARK: Check
//
//            let weather = WeatherModel(cityName: cityName, currentTemperature: currentTemperature, currentTime: currentTime, sunriseTime: sunriseTime, sunsetTime: sunsetTime, currentDate: currentDate)
//
//
//            let dayOrNight = weather.checkIfDayOrNight(current: currentTime, sunrise: sunriseTime, sunset: sunsetTime)
//
//            print(dayOrNight)
//            print(cityName)
//            print(currentTime)
//            print(sunriseTime)
//            print(sunsetTime)
//            print(currentDate)
//            print(weather.temperature)
//
//            return weather
//
//        } catch {
//            delegate?.didFailWithError(error: error)
//            return nil
//        }
//    }
//
//
//    // MARK: - Convert the data in milliseconds for a standard date format
//
//    func convert(from timeInMilliseconds: Int, timeZoneInMillisseconds: Int) -> String? {
//
//        guard let timeZone = TimeZone(secondsFromGMT: timeZoneInMillisseconds) else {
//            return nil
//        }
//
//        let date = Date(timeIntervalSince1970: Double(timeInMilliseconds))
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = timeZone
//        dateFormatter.dateFormat = "HH:mm"
//
//
//        return dateFormatter.string(from: date)
//    }
//
//    func convertToCurrentDate(from timeInMilliseconds: Int, timeZoneInMillisseconds: Int) -> String? {
//
//        guard let timeZone = TimeZone(secondsFromGMT: timeZoneInMillisseconds) else {
//            return nil
//        }
//
//        let date = Date(timeIntervalSince1970: Double(timeInMilliseconds))
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = timeZone
//        dateFormatter.dateFormat = "EEEE, MMM d"
//        let dateString = dateFormatter.string(from: date)
//
//        return dateString
//    }
//
//}
//
//
//
//
//
//
//    /*
//     func convertToDate(from timeInMilliseconds: Int, timeZoneInMillisseconds: Int) -> Date {
//
//     let timeZone = TimeZone(secondsFromGMT: timeZoneInMillisseconds)
//     let date = Date(timeIntervalSince1970: Double(timeInMilliseconds))
//
//
//     let dateFormatter = DateFormatter()
//     dateFormatter.timeZone = timeZone
//
//     return dateFormatter.
//     }
//
//     */
//
//
//    /*
//     quebrar esta função em duas:
//     uma vai retornar uma Date, que pode ser usada tanto para
//     verificar se é dia ou noite;
//     a outra função deve pegar uma date e retornar uma string
//     com o horário formatado.
//     */
//
