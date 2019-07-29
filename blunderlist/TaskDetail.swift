//
//  TaskDetail.swift
//  blunderlist
//
//  Created by Tomas Basham on 27/07/2019.
//  Copyright © 2019 Tomas Basham. All rights reserved.
//

import SwiftUI

struct TaskDetail: View {
  var task: Task

  var body: some View {
    VStack {
      Text(task.title)
      List(task.comments) { comment in
        Text(comment.text)
      }
    }
  }
}

#if DEBUG
struct TaskDetail_Previews: PreviewProvider {
  static var previews: some View {
    TaskDetail(task: Task(id: 1, title: "Hello, World"))
  }
}
#endif
