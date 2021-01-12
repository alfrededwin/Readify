//
//  ApiHelper.swift
//  Readify
//
//  Created by Shakeel Mohamed on 2021-01-02.
//

import Foundation

class ApiHelper {
    
    struct ApiConfig: Codable {
        var baseUrl: String
        var googleBooksApiKey: String
    }
    
    static func getConfig() -> ApiConfig? {
        if let path = Bundle.main.path(forResource: "ApiKeys", ofType: "plist"),
           let xml = FileManager.default.contents(atPath: path),
           let config = try? PropertyListDecoder().decode(ApiConfig.self, from: xml)
        {
            return config
        } else {
            print("plist reading error")
        }
        
        return nil
    }
    
    static func getData <RESPONSE: Codable> (with endpoint: String, completion: @escaping (RESPONSE) -> Void) {
            
        
        let url = URL(string: endpoint)
    

        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
          
            if let error = error {
                    print("Error with fetching data: \(error)")
                    return
            }
                  
            guard let httpResponse = response as? HTTPURLResponse,
               (200...299).contains(httpResponse.statusCode) else {
               print("Error with the response, unexpected status code: \(String(describing: response))")
               return
            }
            

            if let data = data,
               let response = try? JSONDecoder().decode(RESPONSE.self, from: data) {
                
                completion(response)
            }
            else {
                print("Data not available")
            }
        })
        task.resume()
    }
    
    
    static func loadRemoteImage(with endpoint: String, completionHandler: @escaping (_ data: Data?) -> Void) {
        
        let url = URL(string: endpoint)!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          
            if let error = error {
                    print("Error with fetching data: \(error)")
                    return
            }
                  
            guard let httpResponse = response as? HTTPURLResponse,
               (200...299).contains(httpResponse.statusCode) else {
               print("Error with the response, unexpected status code: \(String(describing: response))")
               return
            }
            

            if let data = data {
                completionHandler(data)
            }
            else {
                print("Data not available")
            }
        })
        task.resume()
    }
}
