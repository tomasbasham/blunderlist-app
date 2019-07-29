//
//  Serializer.swift
//  blunderlist
//
//  Created by Tomas Basham on 28/07/2019.
//  Copyright © 2019 Tomas Basham. All rights reserved.
//

import Foundation

/// Serializable 
public protocol Serializable {
  init?(from data: Data)
  init?(_ string: String, using encoding: String.Encoding)
  init?(fromURL url: URL)

  func encode() -> Data?
  func encode(encoding: String.Encoding) -> String?
}

/// An array of codeable elements should conform to the `Serializable` protocol
/// to allow the array and it's elements to be decoded from a wire format into
/// concrete types.
extension Array: Serializable where Element: Codable {}

extension Serializable where Self: Codable {
  public init?(from data: Data) {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601

    guard let task = try? decoder.decode(Self.self, from: data) else {
      return nil
    }

    self = task
  }

  public init?(_ string: String, using encoding: String.Encoding = .utf8) {
    guard let data = string.data(using: encoding) else {
      return nil
    }

    self.init(from: data)
  }

  public init?(fromURL url: URL) {
    guard let data = try? Data(contentsOf: url) else {
      return nil
    }

    self.init(from: data)
  }

  public func encode() -> Data? {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601

    guard let data = try? encoder.encode(self) else {
      return nil
    }

    return data
  }

  public func encode(encoding: String.Encoding = .utf8) -> String? {
    guard let data = self.encode() else {
      return nil
    }

    return String(data: data, encoding: encoding)
  }
}
