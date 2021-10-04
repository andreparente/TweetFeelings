import SnapshotTesting
import XCTest

@testable import TweetFeelings

class FeedViewTests: XCTestCase {
    let viewController = TweetsFeedViewController(viewModel:
                                                    TweetsFeedViewModel(service:
                                                                            ServiceMock(fetchUserCase: .success, fetchTweetsFromUserCase: .success)))

    func testEmptyFeedView() {
        let result = verifySnapshot(matching: viewController,
                                            as: .image(on: .iPhoneX),
                                            named: "EmptyFeedView",
                                            testName: "FeedViewTests")
        XCTAssertNil(result)
    }
    
    func testFeedViewWithResults() {
        viewController.didSearch(for: "Teste")
        let result = verifySnapshot(matching: viewController,
                                            as: .image(on: .iPhoneX),
                                            named: "FeedViewWithResults",
                                            testName: "FeedViewTests")
        XCTAssertNil(result)
    }
}
