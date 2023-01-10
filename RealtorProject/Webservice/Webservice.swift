//
//  Webservice.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/10/23.
//

import Foundation

enum WebError:Error{
    case invalidUrlError, badResponseError
}
class Webservice{
    
    func getData() {
        let apikey = "fsq3fNLNz7CZXYSmSKOYslrHuZnI6Pp1RRCDipdPI4Zm7X8="
        
        let headers = [
            "accept": "application/json",
            "authorization": apikey
        ]
        guard let url = URL(string: "https://api.foursquare.com/v3/places/search") else {return}
//      Build the request
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0
        )
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        let dataTask = URLSession.shared.dataTask(with:request) { data, response, error in
            guard let data = data, error == nil else{
                return
            }
            
            var result:Places?
            do{
                result = try JSONDecoder().decode(Places.self, from: data)
            }catch{
                print(error)
            }
            guard let json = result else {
                return
            }
            print(json.results?.count)
            print(json.results?[0].name)
            print(json.results?.map{$0.name})
            
        }
        dataTask.resume()
    }

}
