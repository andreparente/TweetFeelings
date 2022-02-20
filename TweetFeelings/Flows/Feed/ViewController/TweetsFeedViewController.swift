import UIKit

protocol TweetsFeedViewControllerInterface: AnyObject {
    func updateFeed()
    func showError(_ description: String)
}

class TweetsFeedViewController: UIViewController, HeaderProtocol  {
    var headerType: HeaderType {
        .title(text: "Tweets", logo: nil)
    }
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupHeader()
    }
}

extension TweetsFeedViewController: FeedViewDelegate {
    func didSearch(for username: String) {
        if !username.isEmpty {
            viewModel.fetchTweetsFrom(username: username)
        } else {
            showAlert(title: "Aviso",
                      subtitle: "Busca vazia, digite ao menos um caractere")
        }
    }
}

extension TweetsFeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfTweets > 0 ? 1 : 0
    }
    
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifier) as! ProfileHeaderView
        if let data = viewModel.profileData {
            ProfileHeaderViewBuilder(header: header).build(with: data)
        }
        return header
    }
}

extension TweetsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TweetsFeedViewController: TweetsFeedViewControllerInterface {
    func updateFeed() {
        DispatchQueue.main.async {
            self.feedView.reloadFeed()
        }
    }

    func showError(_ description: String) {
        DispatchQueue.main.async {
            self.showAlert(title: "Erro", subtitle: description)
        }
    }
}
