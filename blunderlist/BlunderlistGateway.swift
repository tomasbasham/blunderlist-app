//
//  Gateway.swift
//  blunderlist
//
//  Created by Tomas Basham on 28/07/2019.
//  Copyright © 2019 Tomas Basham. All rights reserved.
//

import Foundation

struct BlunderlistGateway {
  let client: Client

  enum Endpoints: String, CaseIterable {
    case comments = "http://35.242.131.113/v1/comments"
    case tasks = "http://35.242.131.113/v1/tasks"
  }

  func createComment(_ comment: Comment, result: @escaping (Result<Comment, Error>) -> Void) {
    guard let url = self.client.url(Endpoints.comments.rawValue) else {
      fatalError("Invalid URL.")
    }

    let request = self.request(url: url, method: .post)
    self.client.request(with: request, result: result)
  }

  func createTask(_ task: Task, result: @escaping (Result<Task, Error>) -> Void) {
    guard let url = self.client.url(Endpoints.tasks.rawValue) else {
      fatalError("Invalid URL.")
    }

    let request = self.request(url: url, method: .get)
    self.client.request(with: request, result: result)
  }

  func deleteComment(withId id: Int, result: @escaping (Result<NoContent, Error>) -> Void) {
    guard let url = self.client.url("\(Endpoints.comments.rawValue)/\(id)") else {
      fatalError("Invalid URL.")
    }

    let request = self.request(url: url, method: .delete)
    self.client.request(with: request, result: result)
  }

  func deleteTask(withId id: Int, result: @escaping (Result<NoContent, Error>) -> Void) {
    guard let url = self.client.url("\(Endpoints.tasks.rawValue)/\(id)") else {
      fatalError("Invalid URL.")
    }

    let request = self.request(url: url, method: .delete)
    self.client.request(with: request, result: result)
  }

  func getComments(result: @escaping (Result<[Comment], Error>) -> Void) {
    guard let url = self.client.url(Endpoints.comments.rawValue) else {
      fatalError("Invalid URL.")
    }

    let request = self.request(url: url, method: .get)
    self.client.request(with: request, result: result)
  }

  func getTasks(result: @escaping (Result<[Task], Error>) -> Void) {
    guard let url = self.client.url(Endpoints.tasks.rawValue) else {
      fatalError("Invalid URL.")
    }

    let request = self.request(url: url, method: .get)
    self.client.request(with: request, result: result)
  }

  func getComment(withId id: Int, result: @escaping (Result<Comment, Error>) -> Void) {
    guard let url = self.client.url("\(Endpoints.comments.rawValue)/\(id)") else {
      fatalError("Invalid URL.")
    }

    let request = self.request(url: url, method: .get)
    self.client.request(with: request, result: result)
  }

  func getTask(withId id: Int, result: @escaping (Result<Task, Error>) -> Void) {
    guard let url = self.client.url("\(Endpoints.tasks.rawValue)/\(id)") else {
      fatalError("Invalid URL.")
    }

    let request = self.request(url: url, method: .get)
    self.client.request(with: request, result: result)
  }

  func updateComment(withId id: Int, result: @escaping (Result<Comment, Error>) -> Void) {
    guard let url = self.client.url("\(Endpoints.comments.rawValue)/\(id)") else {
      fatalError("Invalid URL.")
    }

    let request = self.request(url: url, method: .put)
    self.client.request(with: request, result: result)
  }

  func updateTask(withId id: Int, result: @escaping (Result<Task, Error>) -> Void) {
    guard let url = self.client.url("\(Endpoints.tasks.rawValue)/\(id)") else {
      fatalError("Invalid URL.")
    }

    let request = self.request(url: url, method: .put)
    self.client.request(with: request, result: result)
  }

  private func request(url: URL, method: HTTPMethod) -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue

    // TODO: these need to go in a serialiser
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("www.blunderlist.com", forHTTPHeaderField: "Host")

    return request
  }
}
