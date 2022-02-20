import SnapKit
import UIKit

protocol TweetTableViewCellProtocol: AnyObject {
    var tweetLabel: UILabel { get set }
}

public final class TweetTableViewCell: UITableViewCell, Reusable, TweetTableViewCellProtocol {

    lazy var tweetLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        return label
    }()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TweetTableViewCell: ViewCodable {
    
    func setupViews() {
        contentView.addSubview(tweetLabel)
    }
    
    func setupAnchors() {
        
        tweetLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(24)
            make.bottom.lessThanOrEqualToSuperview().inset(24)
        }
    }
    
    func setupLayouts() {
        backgroundColor = .clear
    }
    
}
