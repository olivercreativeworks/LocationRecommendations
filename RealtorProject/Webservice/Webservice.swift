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

protocol ProcessDataDelegate{
    func processData(_ data:Data?, _ response:URLResponse?, _ error:Error?)
}

class Webservice{
    static func getDataFromFourSquareAPI(options: FourSquareAPIUrlOptions, delegate:ProcessDataDelegate) async -> Void {
        var urlString = FourSquareAPIUrlOptionsMapper(options: options).urlString
        guard let url = URL(string: urlString ) else {return}

        let apikey = "fsq3fNLNz7CZXYSmSKOYslrHuZnI6Pp1RRCDipdPI4Zm7X8="

        let headers = [
            "accept": "application/json",
            "authorization": apikey
        ]
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0
        )
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let dataTask = URLSession.shared.dataTask(with:request)
        {
            data, response, error in delegate.processData(data, response, error)
        }

        dataTask.resume()
    }
}
