//
//  AccpetanceTests.swift
//  UnrdiOSAppTests
//
//  Created by Julian Ramkissoon on 02/11/2020.
//  Copyright © 2020 jellyfishapps. All rights reserved.
//

import Foundation

import XCTest
import UnrdiOS
@testable import UnrdiOSApp
import Unrd
import AVKit

final class AcceptanceTests: XCTestCase {
    func test_onLaunch_displaysStoryInformation() {
        let storyViewController = launch(httpClient: .online(response))
       
        XCTAssertEqual(storyViewController.nameLabel.text, "My Last 3 Days")
        XCTAssertEqual(storyViewController.shortSummaryLabel.text, "A short summary")
    }
    
    func test_onLaunch_displaysCorrectVideo() {
        let storyViewController = launch(httpClient: .online(response))
         
        XCTAssertEqual((storyViewController.videoViewContainer?.player?.currentItem?.asset as! AVURLAsset).url,  URL(string: "https://d1puk6yab42f06.cloudfront.net/4a9036ea6cda255468ec9397e1d7046a97f6f0604eca62fcf5a5760080c4e310_ee4344d9a8d8c574a443285c804d831d.mp4")!)
      }
    
    // MARK: - Helpers
    
    private func launch(
        httpClient: HTTPClientStub
    ) -> StoryViewController {
        let sut = SceneDelegate(httpClient: httpClient)
        sut.window = UIWindow()
        sut.configureWindow()
        
        let storyViewController = sut.window?.rootViewController as! StoryViewController
        storyViewController.loadViewIfNeeded()
        
        return storyViewController
    }
    
    private func response(for url: URL) -> (Data) {
        return (makeFeedData())
     }
    
    private func makeStory(id: Int, name: String, shortSummary: String, fullSummary: String, introVideos: [MediaItem]) -> (story: StoryItem, json: [String: Any]) {
        let story = StoryItem(storyId: id, name: name, shortSummary: shortSummary, fullSummary: fullSummary, introVideos: introVideos)
        let videosJSON = ["resource_uri": story.introVideos![0].resourceUri!.absoluteString]
        
        let storyJSON: [String: Any] = ["story_id": story.storyId,
                                        "name": story.name,
                                        "short_summary": story.shortSumary,
                                        "full_summary": story.fullSummary,
                                        "intro_video": [videosJSON]]
        
        let validJSON = ["result": storyJSON]
        
        return (story, validJSON)
    }

    private func makeMediaItem(resourceUri: URL?) -> MediaItem {
        return MediaItem(resourceUri: resourceUri)
    }

     private func makeFeedData() -> Data {
        return try! JSONSerialization.data(withJSONObject: makeStory(id: 122, name: "My Last 3 Days", shortSummary: "A short summary", fullSummary: "A full summary", introVideos:[ makeMediaItem(resourceUri: URL(string: "https://d1puk6yab42f06.cloudfront.net/4a9036ea6cda255468ec9397e1d7046a97f6f0604eca62fcf5a5760080c4e310_ee4344d9a8d8c574a443285c804d831d.mp4")!)]).json)
     }

}

class HTTPClientStub: HTTPClient {

   private let stub: (URL) -> HTTPClientResult

       init(stub: @escaping (URL) -> HTTPClientResult) {
       self.stub = stub
   }


   func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)  {
       completion(stub(url))
   }
}

extension HTTPClientStub {
   static func online(_ stub: @escaping (URL) -> (Data)) -> HTTPClientStub {
       HTTPClientStub { url in .success(stub(url)) }
   }
}
