//
//  GoogleAPI.swift
//  TweetFeelings
//
//  Created by Andre Parente on 01/10/21.
//

import Foundation
//ANALISAR TEXTO (POST): https://language.googleapis.com/v1/documents:analyzeSentiment?key=AIzaSyBH7koCAq2AVKy-9AXEBe876fA0bpCYWJs


//BODY DO POST DE ANALISAR TEXTO:
/*{
"document": {
   "type": PLAIN_TEXT,
   "language": "pt_BR",
   "content": string,
   "gcsContentUri": string
},
"encodingType": UTF8
}*/


//CHAVE DE API GOOGLE AIzaSyBH7koCAq2AVKy-9AXEBe876fA0bpCYWJs
public enum GoogleAPI: Route {
    
    case analyze(text: String)
    
    var endpoint: String {
        ""
    }
    
    private var baseURL: String {
        "https://language.googleapis.com/v1/documents:analyzeSentiment?key=AIzaSyBH7koCAq2AVKy-9AXEBe876fA0bpCYWJs"
    }

    private var body: Data? {
        switch self {
        case let .analyze(text):
            var json = [String: Any]()
            json["encodingType"] = "UTF8"
            json["document"] = ["type": "PLAIN_TEXT", "language": "pt_BR", "content": text]
            return try? JSONSerialization.data(withJSONObject: json)
        }
        
    }
    var urlRequest: URLRequest? {
        guard let url = URL(string: baseURL) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = body
        return urlRequest
    }
}
