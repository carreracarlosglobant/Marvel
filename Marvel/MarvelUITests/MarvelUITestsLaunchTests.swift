//
//  MarvelUITestsLaunchTests.swift
//  MarvelUITests
//
//  Created by Juan Carlos  Carrera on 06/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import XCTest

class MarvelUITestsLaunchTests: XCTestCase {

  override class var runsForEachTargetApplicationUIConfiguration: Bool {
    true
  }

  override func setUpWithError() throws {
    continueAfterFailure = false
  }

  func testLaunch() throws {
    let app = XCUIApplication()
    app.launch()
    let attachment = XCTAttachment(screenshot: app.screenshot())
    attachment.name = "Launch Screen"
    attachment.lifetime = .keepAlways
    add(attachment)
  }

  func test_screenPresentingMarvelCharactersSuccess() {
    //given
    let app = XCUIApplication()
    //when
    app.launch()
    //then
    XCTAssertTrue(app.tables["marvelCharacters"].exists)
  }

  // MARK: - Network dependency
  func test_screenPresentingCharacterDetialSuccess() {
    //given
    let app = XCUIApplication()
    //when
    app.launch()
    app.tables["marvelCharacters"].cells["characterTableViewCell1"].tap()
    //then
    XCTAssertTrue(app.images["characterImageView"].exists)
  }
}
