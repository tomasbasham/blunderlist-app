//
//  Task.swift
//  blunderlist
//
//  Created by Tomas Basham on 27/07/2019.
//  Copyright © 2019 Tomas Basham. All rights reserved.
//

import SwiftUI

struct Task: Codable, Hashable, Identifiable, Serializable {
  var id: Int
  var title: String
  var completed: Bool = false
  var createdAt: Date = Date()

  var comments: [Comment] = []
}

// - MARK: properties

extension Task {
  var hasComments: Bool {
    self.comments.count > 0
  }
}
