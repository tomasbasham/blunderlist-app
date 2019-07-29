//
//  TaskRow.swift
//  blunderlist
//
//  Created by Tomas Basham on 27/07/2019.
//  Copyright © 2019 Tomas Basham. All rights reserved.
//

import SwiftUI

struct TaskRow: View {
  var task: Task

  var body: some View {
    HStack {
      Button(action: {
        print("Clicked checkmark")
      }, label: {
        Image(systemName: task.completed ? "checkmark.square" : "square")
      })

      Text(task.title)
      Spacer()

      if task.hasComments {
        Image(systemName: "text.bubble")
      }
    }
    .padding()
  }
}

#if DEBUG
struct TaskRow_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      TaskRow(task: Task(id: 1, title: "Hello"))
      TaskRow(task: Task(id: 2, title: "World"))
    }
    .previewLayout(.fixed(width: 300, height: 70))
  }
}
#endif
