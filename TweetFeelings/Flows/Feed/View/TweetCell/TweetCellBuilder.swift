import Foundation

class TweetTableViewCellBuilder {
    var cell: TweetTableViewCellProtocol
    
    init(cell: TweetTableViewCellProtocol) {
        self.cell = cell
    }
    
    func build(with text: String) {
        cell.tweetLabel.text = text
    }
}
