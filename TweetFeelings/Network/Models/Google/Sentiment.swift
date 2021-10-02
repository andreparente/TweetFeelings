/*
 Most negative sentiment value: -1,0
 Most positive sentiment value:  1,0
 For test purpose, I`m admiting that
 Neutral is between -0.2 and 0.2
 Happiness is greater than 0.2
 Sadness is lower than -0.2
*/
enum Sentiment {
    case happiness
    case neutral
    case sadness
    
    init(_ score: Double) {
        if score > 0.2 {
            self = .happiness
        } else  if score < (-0.2) {
            self = .sadness
        } else {
            self = .neutral
        }
    }
    
    var emoji: String {
        switch self {
        case .neutral:
            return "😐"
        case .happiness:
            return "😄"
        case .sadness:
            return "😞"
        }
    }
}
