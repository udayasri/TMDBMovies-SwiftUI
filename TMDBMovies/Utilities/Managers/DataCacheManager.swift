//
//  DataCacheManager.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import Foundation

protocol DataCacheManagerProtocol {
    func cacheData<T: Codable>(_ dataArray: [T], fileName: String)
    func getCachedData<T: Codable>(fileName: String) -> [T]?
    func isCacheExpired(fileName: String, cacheDuration: TimeInterval) -> Bool
    
}

final class DataCacheManager: DataCacheManagerProtocol {
    
    /// Caches JSON data from the specified URL and decodes it into the provided codable type.
    /// - Parameters:
    ///   - dataArray: data array
    ///   - fileName: fileName
    func cacheData<T: Codable>(_ dataArray: [T], fileName: String) {
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let cacheURL = cacheDirectory.appendingPathComponent(fileName + ".json")
        let metadataURL = cacheDirectory.appendingPathComponent(fileName + "_metadata.json")
        
        do {
            let data = try JSONEncoder().encode(dataArray)
            try data.write(to: cacheURL)
            let timestamp = Date().timeIntervalSince1970
            let metadata = ["timestamp": timestamp]
            let metadataData = try JSONSerialization.data(withJSONObject: metadata, options: [])
            try metadataData.write(to: metadataURL)
        } catch {
            // TODO: Handle Errors
            print("Error caching data: \(error.localizedDescription)")
        }
    }
    
    /// Retrieves CachedData for a given file name
    /// - Parameter fileName: file name
    /// - Returns: decoded data
    func getCachedData<T: Codable>(fileName: String) -> [T]? {
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let cacheURL = cacheDirectory.appendingPathComponent(fileName + ".json")
        
        do {
            let cachedData = try Data(contentsOf: cacheURL)
            let decodedData = try JSONDecoder().decode([T].self, from: cachedData)
            return decodedData
        } catch {
            // TODO: Handle Errors
            print("Error retrieving cached data: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// Check if the cached data has been expired for a given file name
    /// - Parameter fileName: file name
    /// - Returns: True / False
    func isCacheExpired(fileName: String, cacheDuration: TimeInterval) -> Bool {
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let metadataURL = cacheDirectory.appendingPathComponent(fileName + "_metadata.json")
        
        do {
            let metadataData = try Data(contentsOf: metadataURL)
            let metadata = try JSONSerialization.jsonObject(with: metadataData, options: []) as? [String: Any]
            if let timestamp = metadata?["timestamp"] as? TimeInterval {
                let currentTime = Date().timeIntervalSince1970
                let timeDifference = currentTime - timestamp
                return timeDifference > cacheDuration
            }
        } catch {
            // TODO: Handle Errors
            print("Error checking cache expiry: \(error.localizedDescription)")
        }
        return true
    }
}
