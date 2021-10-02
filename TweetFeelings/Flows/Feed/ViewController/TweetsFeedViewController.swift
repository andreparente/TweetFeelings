import UIKit

protocol TweetsFeedViewControllerInterface: AnyObject {
    func updateFeed()
    func showSentiment(_ text: String)
}

class TweetsFeedViewController: UIViewController  {
    
    private var viewModel: TweetsFeedViewModelInterface
    private lazy var feedView: FeedView = {
        let feedView = FeedView(feedDelegate: self, feedDataSource: self)
        feedView.delegate = self
        return feedView
    }()
    
    init(viewModel: TweetsFeedViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = feedView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TweetsFeedViewController: FeedViewDelegate {
    func didSearch(for username: String?) {
        if let username = username {
            viewModel.fetchTweetsFrom(username: username)
        } else {
            //search vazia
        }
    }
}

extension TweetsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfTweets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as! TweetTableViewCell
        if let tweet = viewModel.tweet(at: indexPath.row) {
            TweetTableViewCellBuilder(cell: cell).build(with: tweet)
        }
        return cell
    }
}

extension TweetsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //TODO: SHOW EMOTION FOR TEXT
        viewModel.analyzeText(at: indexPath.row)
    }
}

extension TweetsFeedViewController: TweetsFeedViewControllerInterface {
    func updateFeed() {
        DispatchQueue.main.async { [weak self] in
            self?.feedView.reloadFeed()
        }
    }
    
    func showSentiment(_ text: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Sentimento do tweet",
                                          message: text,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .cancel,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
