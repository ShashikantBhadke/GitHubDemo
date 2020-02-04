//
//  WebService.swift
//  GitHubApp
//
//  Created by Shashikant's_Macmini on 04/02/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

class WebService {
    
    //MARK:- URL's
    static var isStaging = true
    static private var MAIN_URL: String  = {
        if isStaging {
            return "https://api.github.com/"
        } else {
            return "https://api.github.com/"
        }
    }()
    
    //MARK:- Error's
    static let URL_ERROR = "Oops something went. Please try again!"
    
    //MARK:- Headers
    private static var header: [String: String] = [:]
    
    
    //MARK:- Variables
    private static let apiQueue = DispatchQueue(label: "com.APICalls", qos: .utility)
    
    private init(){}
    
    //MARK:- API Calls
    class func call<T: Decodable>(withAPIType type: HTTPRequest = .GET, withAPI subUrl: SubURL, strID: String = "" , withParameters param: [String: Any] = [:], withDecodabel _decode : T.Type, complection: @escaping(ResultAPI<T>)->()){
        var httpBody = Data()
        
        var finalPath = MAIN_URL + subUrl.rawValue
        if !strID.isEmpty {
            finalPath += ("/" + strID)
        }
        
        guard var _url = URLComponents(string: finalPath) else {
            complection(.Error(URL_ERROR))
            return
        }
        
        do {
            httpBody = try JSONSerialization.data(withJSONObject: param, options: [])
        } catch let error {
            complection(.Error(error.localizedDescription))
            return
        }
        if type == .GET {
            var getParam = [String: String]()
            for (key, value) in param {
                getParam[key] = "\(value)"
            }
            
            _url.queryItems = getParam.map{ (key, value) in
                return URLQueryItem(name: key, value: value)
            }
        }
        var request = URLRequest(url: _url.url!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")    
        request.addValue("1e9634e262b1ef8b3503969cf732a54ad3b87989", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = type.rawValue
        if type != .GET {
            request.httpBody = httpBody
        }
        request.timeoutInterval = 60.0
        debugPrint("Request URL:- \(_url)")
        debugPrint("Request With Param:- \(param)")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                var statusCode = 0
                if let httpResponse = response as? HTTPURLResponse {
                    statusCode = httpResponse.statusCode
                }
                debugPrint("StatusCode:- ",statusCode)
                guard let data = data, error == nil else {
                    complection(.Error(error?.localizedDescription ?? URL_ERROR))
                    return
                }
                do {
                    let parsedObj = try JSONDecoder().decode(T.self, from: data)
                    complection(.Success(parsedObj, data))
                } catch let decodingError {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        debugPrint(json ?? [:])
                    } catch let decodingError {
                        debugPrint("fail to parse again", decodingError.localizedDescription)
                    }
                    complection(.Error(decodingError.localizedDescription))
                    debugPrint("fail to parse again", decodingError.localizedDescription)
                }
            }
        }.resume()
    }
    
    class func callWithMedia<T: Decodable>(withAPIType type: HTTPRequest = .GET, withAPI subUrl: SubURL, withParameters param: [String: String] = [:], withMedia media: [Media]?, withDecodabel _decode : T.Type, complection: @escaping(ResultAPI<T>)->()){
        
        guard let url = URL(string: MAIN_URL + subUrl.rawValue) else {
            complection(.Error(URL_ERROR))
            return
        }
        let boundary = generateBoundary()
        var request = URLRequest(url: url)
        let dataBody = createDataBody(withParameters: param, media: media, boundary: boundary)
        
        request.httpMethod = type.rawValue
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = dataBody
        
        debugPrint("Request URL:- \(url)")
        apiQueue.async {
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    var statusCode = 0
                    if let httpResponse = response as? HTTPURLResponse {
                        statusCode = httpResponse.statusCode
                    }
                    debugPrint("StatusCode:- ",statusCode)
                    guard let data = data, error == nil else {
                        complection(.Error(error?.localizedDescription ?? URL_ERROR))
                        return
                    }
                    
                    do {
                        let parsedObj = try JSONDecoder().decode(T.self, from: data)
                        complection(.Success(parsedObj, data))
                    } catch let decodingError {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                            debugPrint(json ?? [:])
                        } catch let decodingError {
                            debugPrint("Unable to parse data with error: \(decodingError.localizedDescription)")
                        }
                        debugPrint(decodingError.localizedDescription)
                        complection(.Error(decodingError.localizedDescription))
                    }
                }
            }.resume()
        }
    }
    
    class private func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    class private func createDataBody(withParameters params: [String: String]?, media: [Media]?, boundary: String) -> Data {
        
        debugPrint(params ?? [:])
        if media != nil {
            debugPrint(media!)
        }
        
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
    
}//class

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}//extension

public enum ResultAPI<T> {
    case Success(T, Data)
    case Error(String)
}

struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "userImage.jpg"
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        self.data = data
    }
}//struct

///ENUM FOR SUB URLS LIKE SIGN IN OR UP, OTP SEND AND OTHERS
enum SubURL: String{
    case searchUsers            = "search/users"
    case usersName              = "users"
}//enum

///ENUM FOR REQUEST TYPE
enum HTTPRequest: String {
    case GET    = "GET"
    case POST   = "POST"
    case PUT    = "PUT"
    case PATCH  = "PATCH"
}//enum
