//
//  File.swift
//  Networking
//
//  Created by Mohamed Makhlouf Ahmed on 19/05/2026.
//

import Foundation
import CoreModels

public enum NetworkError: Error,Equatable {
    case badURL
    case Transport(TransportError)
    case httpResponse
    case httpStatusCode(Int)
    case decoding
}

public enum TransportError: Error, Equatable {
    case offline, timedOut, dnsFailure, cannotConnect, cancelled, tlsFailure, unknown

    public init(urlError: URLError) {
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
}


extension NetworkError {
    public func toAppError() -> AppError {
        switch self {
        case .Transport(let transport):
            switch transport {
            case .offline:
                return .offline
            case .timedOut:
                return .timedOut
            case .dnsFailure, .cannotConnect, .tlsFailure:
                return .serverError
            case .cancelled, .unknown:
                return .unknown
            }
        case .httpStatusCode(let code):
            switch code {
            case 401, 403:
                return .unauthorized
            case 404:
                return .notFound
            case 500...599:
                return .serverError
            default:
                return .unknown
            }
        case .decoding:
            return .decoding
        case .badURL, .httpResponse:
            return .unknown
        }
    }
}
