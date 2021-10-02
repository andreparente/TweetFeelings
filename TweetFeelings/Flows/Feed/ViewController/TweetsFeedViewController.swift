import UIKit

protocol TweetsFeedViewControllerInterface: AnyObject {
    func updateFeed()
    func showSentiment(_ text: String)
    func showError(_ description: String)
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
}

extension TweetsFeedViewController: FeedViewDelegate {
    func didSearch(for username: String) {
        if !username.isEmpty {
            viewModel.fetchTweetsFrom(username: username)
        } else {
            showAlert(title: "Aviso", subtitle: "Busca vazia, digite ao menos um caractere")
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
        viewModel.analyzeText(at: indexPath.row)
    }
}

extension TweetsFeedViewController: TweetsFeedViewControllerInterface {
    func updateFeed() {
        DispatchQueue.main.async {
            self.feedView.reloadFeed()
        }
    }
    
    func showSentiment(_ text: String) {
        showAlert(title: "Sentimento do tweet", subtitle: text)
    }
    
    func showError(_ description: String) {
        showAlert(title: "Erro", subtitle: description)
    }
    
    private func showAlert(title: String, subtitle: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: subtitle,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .cancel,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
