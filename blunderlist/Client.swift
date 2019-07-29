//
//  Client.swift
//  blunderlist
//
//  Created by Tomas Basham on 28/07/2019.
//  Copyright © 2019 Tomas Basham. All rights reserved.
//

import Foundation

// Is this an example of a deserialiser? Could this be converted to a JSON:API
// decoder? Will I need the equivalent encoder?
public struct APIResponse<Data: Decodable>: Decodable {
  let message: String?
  let data: Data?
}

/// NoContent represents an empty HTTP response body whilst maintaining
/// compatability with `APIResponse`.
public struct NoContent: Codable, Serializable {}

/// Deserializable composes both the `Decodable` and `Serializable` types to
/// represent a concrete type that can be decoded from a wire format and then
/// initialised with the raw data.
public typealias Deserializable = Decodable & Serializable

/// HTTPMethod describes the acceptable HTTP verbs to be used with this API.
public enum HTTPMethod: String, CaseIterable {
  case get = "GET"
  case head = "HEAD"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
  case options = "OPTIONS"
}

/// ClientError describes error types that may be returned from the client.
public enum ClientError: Error {
  case badResponse
  case decoding
  case encoding
  case missing
  case server(status: Int, message: String)
}

/// Client
public struct Client {
  public var transport: Transportable = URLSessionAdapter()
}

// - MARK: Request methods

extension Client {
  public func request<DecodableType: Deserializable>(with request: URLRequest, result: @escaping (Result<DecodableType, Error>) -> Void) {
    self.transport.dataTask(with: request) { _result in
      switch _result {
      case .success(let (data, httpResponse)):
        guard let apiResponse = DecodableType.init(from: data) as? APIResponse<DecodableType> else {
          return result(.failure(ClientError.decoding))
        }

        // Check the status code indicates success.
        guard 200..<299 ~= httpResponse.statusCode else {
          let error = ClientError.server(status: httpResponse.statusCode, message: apiResponse.message!)
          return result(.failure(error))
        }

        if let mimeType = httpResponse.mimeType, mimeType != "application/json" {
          return result(.failure(ClientError.badResponse))
        }

        guard let data = apiResponse.data else {
          return result(.failure(ClientError.missing))
        }

        result(.success(data))
      case .failure(let error):
        result(.failure(error))
      }
    }
  }
}

// - MARK: URL methods

extension Client {
  public func url(_ endpoint: String, parameters: [String: String]?) -> URL? {
    let rawURL = URL(string: endpoint)

    guard let url = rawURL, var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
      return nil
    }

    let queryItems = parameters?.map { (key, value) in
      return URLQueryItem(name: key, value: value)
    }

    components.queryItems = queryItems
    return components.url
  }

  public func url(_ endpoint: String) -> URL? {
    return self.url(endpoint, parameters: nil)
  }
}
