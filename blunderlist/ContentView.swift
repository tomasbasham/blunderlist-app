//
//  ContentView.swift
//  blunderlist
//
//  Created by Tomas Basham on 14/07/2019.
//  Copyright © 2019 Tomas Basham. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var gateway = BlunderlistGateway(client: Client())
  var tasks: [Task] = []

  var body: some View {
    TabbedView {
      TaskList(tasks: tasks)
        .tabItem { Text("tasks") }
        .tag(0)
      TaskList(tasks: tasks) { $0.completed == false }
        .tabItem { Text("active") }
        .tag(1)
      TaskList(tasks: tasks) { $0.completed == true }
        .tabItem { Text("completed") }
        .tag(2)
    }.onAppear {
      self.gateway.getTasks { (result) in
        switch result {
        case .success(let tasks):
          print(tasks)
        case .failure(let error):
          print(error)
        }
      }
    }
  }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif
