//
//  Transport.swift
//  blunderlist
//
//  Created by Tomas Basham on 28/07/2019.
//  Copyright © 2019 Tomas Basham. All rights reserved.
//

import Foundation

/// RawResponse is a tuple representing both the raw data and HTTP response
/// from a request. This is not a value type because it does not form a
/// conceptual entity but is used instead for convenience when supplying a
/// single type to `Result`.
public typealias RawResponse = (Data, HTTPURLResponse)

/// Transportable is a protocol used to decouple the implementation of the
/// transport layer from the client. This is important allow other
/// implementations to be injected into the client to facilitate local
/// development and testing and negate the need for a local server running.
public protocol Transportable {
  func dataTask(with request: URLRequest, result: @escaping (Result<RawResponse, Error>) -> Void)
}

/// TransportableDelegate is a protocol to enable a type conforming to
/// `Transportable` to hand-off responsibility of lifecycle events. These can
/// be used to update UI elements whilst a request is in flight.
public protocol TransportableDelegate {
  func transportDidStart(_ transport: Transportable)
  func transportDidEnd(_ transport: Transportable)
}

/// URLSessionAdapter
public struct URLSessionAdapter: Transportable {
  public var urlSession = URLSession.shared
  public var delegate: TransportableDelegate?

  public func dataTask(with request: URLRequest, result: @escaping (Result<RawResponse, Error>) -> Void) {
    self.urlSession.dataTask(with: request) { (data, response, error) in
      if let error = error {
        return result(.failure(error))
      }

      guard let data = data, let httpResponse = response as? HTTPURLResponse else {
        let error = NSError(domain: "error", code: 0, userInfo: nil)
        return result(.failure(error))
      }

      result(.success((data, httpResponse)))
    }.resume()
  }
}
