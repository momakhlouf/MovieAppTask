//
//  File.swift
//  Networking
//
//  Created by Mohamed Makhlouf Ahmed on 19/05/2026.
//

import Foundation

public enum NetworkError: Error,Equatable {
    case badURL
    case Transport(TransportError)
    case httpResponse
    case httpStatusCode(Int)
    case decoding
   public var userMessage: String{
        switch self {
        case .Transport(let transportError):
            return transportError.userMessage
        case .httpResponse:
            return "Invalid server response."
        case .httpStatusCode(let code):
            switch code {
            case 400: return "Bad request"
            case 401: return "Your session has expired. please sign in again"
            case 403: return "You are not authorized to perform this action"
            case 404: return "Not found"
            case 429: return "Too many requests"
            case 500: return "the server is having trouble, please try again later"
            default: return  "Something went wrong, please try again later"
            }
        default: return "Something went wrong, please try again later"
        }
    }
}

public enum TransportError: Error, Equatable {
    case offline, timedOut, dnsFailure, cannotConnect, cancelled, tlsFailure, unknown

    init(urlError: URLError) {
        switch urlError.code {
        case .notConnectedToInternet,
             .networkConnectionLost,
             .dataNotAllowed:
            self = .offline

        case .timedOut:
            self = .timedOut

        case .dnsLookupFailed, .cannotFindHost:
            self = .dnsFailure

        case .cannotConnectToHost:
            self = .cannotConnect

        case .cancelled:
            self = .cancelled

        case .secureConnectionFailed,
             .serverCertificateHasBadDate,
             .serverCertificateUntrusted,
             .serverCertificateHasUnknownRoot,
             .serverCertificateNotYetValid:
            self = .tlsFailure

        default:
            self = .unknown
        }
    }

    var userMessage: String {
        switch self {
        case .offline:
            return "You appear to be offline. Check your internet connection and try again."
        case .timedOut:
            return "The request timed out. Please try again."
        case .dnsFailure, .cannotConnect:
            return "We can't reach the server right now."
        case .cancelled:
            return "Request was cancelled."
        case .tlsFailure:
            return "Secure connection failed."
        case .unknown:
            return "A network error occurred. Please try again later."
        }
    }
}


extension NetworkError {
  public static func map(_ error: Error) -> NetworkError {
        if let networkError = error as? NetworkError {
            return networkError
        }

        if let urlError = error as? URLError {
            return .Transport(TransportError(urlError: urlError))
        }

        return .httpResponse
    }
}
