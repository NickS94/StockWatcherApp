//
//  ApiErrors.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 27.08.24.
//

import Foundation


// Enum to handle the ApiErrors
enum ApiErrors:String, Error{
    case invalidUrl = "The Url is Invalid"
    case badResponse = "Bad Server Response"
    case notFound = "Subject not found"
    case decodingError = "Failed to Decode"
    case tooManyRequests = "Too Many Requests"
    case authenticationMissing = "Not Authenticated"
    case unknownError = "Wat da fuk"
}



