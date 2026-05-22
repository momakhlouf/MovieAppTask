//
//  File.swift
//  Networking
//
//  Created by Mohamed Makhlouf Ahmed on 18/05/2026.
//

import Foundation

public enum APIConfig{
    public static let baseURL = URL(string: "https://api.themoviedb.org/3/")!
    public static let apiKey = "15fe946886608e9b2315244355fb5b94"
  //  API_KEY = YOUR_API_KEY_HERE
   // it suppose to be in Secrets.xcconfig
    #warning("handle api key")
}
