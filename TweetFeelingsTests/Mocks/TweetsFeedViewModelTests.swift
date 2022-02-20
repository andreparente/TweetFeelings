import XCTest
@testable import TweetFeelings

class TweetsFeedViewModelTests: XCTestCase {
    var viewModel: TweetsFeedViewModel!
    var serviceMock: ServiceMock!
    var controllerMock: FeedViewControllerMock!
    
    override func tearDown() {
        super.tearDown()
        serviceMock = nil
        viewModel = nil
        controllerMock = nil
    }
    
    func testFetchTweets() {
        let tweetsMock = TweetsMock()
        serviceMock = ServiceMock(fetchUserCase: .success,
                                  fetchTweetsFromUserCase: .success)
        viewModel = TweetsFeedViewModel(service: serviceMock)
        controllerMock = FeedViewControllerMock(viewModel: viewModel)
        viewModel.controllerDelegate = controllerMock
        viewModel.fetchTweetsFrom(username: "teste")
        let randomIndex = Int.random(in: 0..<tweetsMock.maxIndex)
        
        XCTAssertEqual(viewModel.numberOfTweets,
                       tweetsMock.tweets.count)
        XCTAssertEqual(viewModel.tweet(at: randomIndex),
                       tweetsMock.tweets[randomIndex].text)
        XCTAssertTrue(controllerMock.didUpdateFeed)
    }

    func testErrorOnFetchUser() {
        let tweetsMock = TweetsMock()
        serviceMock = ServiceMock(fetchUserCase: .error,
                                  fetchTweetsFromUserCase: .success)
        viewModel = TweetsFeedViewModel(service: serviceMock)
        controllerMock = FeedViewControllerMock(viewModel: viewModel)
        viewModel.controllerDelegate = controllerMock
        viewModel.fetchTweetsFrom(username: "teste")
        let randomIndex = Int.random(in: 0..<tweetsMock.maxIndex)
        XCTAssertTrue(controllerMock.didShowError)
    }
    
    func testErrorOnFetchTweets() {
        let tweetsMock = TweetsMock()
        serviceMock = ServiceMock(fetchUserCase: .success,
                                  fetchTweetsFromUserCase: .error)
        viewModel = TweetsFeedViewModel(service: serviceMock)
        controllerMock = FeedViewControllerMock(viewModel: viewModel)
        viewModel.controllerDelegate = controllerMock
        viewModel.fetchTweetsFrom(username: "teste")
        let randomIndex = Int.random(in: 0..<tweetsMock.maxIndex)
        XCTAssertTrue(controllerMock.didShowError)
    }
}
