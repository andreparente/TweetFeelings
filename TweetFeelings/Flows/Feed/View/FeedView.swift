import UIKit

protocol FeedViewDelegate: AnyObject {
    func didSearch(for username: String)
}

class FeedView: UIView {
    
    var delegate: FeedViewDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var usernameSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }()
    
    init(frame: CGRect = .zero,
         feedDelegate: UITableViewDelegate?,
         feedDataSource: UITableViewDataSource?) {
        super.init(frame: frame)
        tableView.delegate = feedDelegate
        tableView.dataSource = feedDataSource
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadFeed() {
        tableView.reloadData()
    }
}

extension FeedView: ViewCodable {
    func setupViews() {
        addSubview(usernameSearchBar)
        addSubview(tableView)
    }
    
    func setupAnchors() {
        usernameSearchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
            make.leftMargin.rightMargin.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(usernameSearchBar.snp.bottom)
            make.rightMargin.leftMargin.equalToSuperview()
            make.bottomMargin.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func setupLayouts() {
        backgroundColor = .white
    }
}

extension FeedView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.didSearch(for: searchBar.text ?? "")
        searchBar.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
