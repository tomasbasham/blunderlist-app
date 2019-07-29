//
//  Comment.swift
//  blunderlist
//
//  Created by Tomas Basham on 28/07/2019.
//  Copyright © 2019 Tomas Basham. All rights reserved.
//

import SwiftUI

struct Comment: Codable, Hashable, Identifiable, Serializable {
  var id: Int
  var text: String
  var author: String
  var createdAt: Date = Date()
}
