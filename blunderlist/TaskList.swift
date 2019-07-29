//
//  TaskList.swift
//  blunderlist
//
//  Created by Tomas Basham on 28/07/2019.
//  Copyright © 2019 Tomas Basham. All rights reserved.
//

import SwiftUI

typealias taskFilter = (Task) -> Bool

struct TaskList: View {
  var tasks: [Task] = []

  /// filter is a closure returning true for each `Task` that is to remain in
  /// the data set when displayed on screen. By default it returns true for any
  /// `Task` passed.
  var filter: taskFilter = { _ in true }

  var body: some View {
    NavigationView {
      List(tasks.filter(filter)) { task in
        NavigationLink(destination: TaskDetail(task: task)) {
          TaskRow(task: task)
        }
      }
      .navigationBarTitle("Tasks")
    }
  }
}

#if DEBUG
struct TaskList_Previews: PreviewProvider {
  static var previews: some View {
    TaskList()
  }
}
#endif
