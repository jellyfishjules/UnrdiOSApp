//
//  SceneDelegateTests.swift
//  UnrdiOSAppTests
//
//  Created by Julian Ramkissoon on 02/11/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import XCTest
import UnrdiOS
@testable import UnrdiOSApp

final class SceneDelegateTests: XCTestCase {
    func test_sceneWillConnect_configuresRootViewController() {
        let sut = SceneDelegate()
        sut.window = UIWindow()
       
        sut.configureWindow()
        
        XCTAssertTrue(sut.window?.rootViewController is StoryViewController)
    }
}
