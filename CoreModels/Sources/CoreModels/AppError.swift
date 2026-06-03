//
//  File.swift
//  CoreModels
//
//  Created by Mohamed Makhlouf Ahmed on 02/06/2026.
//

import Foundation

public enum AppError: Error, Equatable {
    case offline
    case timedOut
    case notFound
    case unauthorized
    case serverError
    case decoding
    case unknown

    public var userMessage: String {
        switch self {
        case .offline:     
            return "You appear to be offline. Check your connection and try again."
        case .timedOut:     
            return "The request timed out. Please try again."
        case .notFound:     
            return "The requested content was not found."
        case .unauthorized:  
            return "Your session has expired. Please sign in again."
        case .serverError:  
            return "The server is having trouble. Please try again later."
        case .decoding:     
            return "Something went wrong processing the response."
        case .unknown:       
            return "Something went wrong. Please try again later."
        }
    }
}
