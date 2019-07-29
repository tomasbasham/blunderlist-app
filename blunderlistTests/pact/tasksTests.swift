//
//  tasksTests.swift
//  blunderlistTests
//
//  Created by Tomas Basham on 28/07/2019.
//  Copyright © 2019 Tomas Basham. All rights reserved.
//

import XCTest
@testable import blunderlist

class tasksTests: XCTestCase {
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testExample() {
    let client = Client()
    let gateway = BlunderlistGateway(client: client)
  }
}
