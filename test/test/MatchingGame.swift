import Foundation

class MatchingGame    {
    
    var cards=Array<Card>()
    var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    }
                    else{
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index:Int)->Int{
        var score = 0
        print(index)
        print(cards[index].isFlited)
        print(indexOfOneAndOnlyFaceUpCard)
        if let a = indexOfOneAndOnlyFaceUpCard{
            print(cards[a].isFlited)
        }
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex] == cards[index]{
                    cards[index].isFaceUp = true
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    cards[index].isFaceUp = true
                    score += 1
                }//matched
                else{
                    cards[index].isFaceUp = true
                    if cards[index].isFlited == true{
                        print(-1)
                        score -= 1
                    }
                    if cards[matchIndex].isFlited == true{
                        print(-1)
                        score -= 1
                    }
                    cards[index].isFlited = true
                    cards[matchIndex].isFlited = true
                }
                //indexOfOneAndOnlyFaceUpCard = nil
            }else if let matchIndex1 = indexOfOneAndOnlyFaceUpCard, matchIndex1 == index{
                cards[index].isFaceUp = false
                cards[index].isFlited = true
            }// has another previous card face up
            else{//no cards face up or 2 cards are face up
                //for flipDownIndex in cards.indices{
                //    cards[flipDownIndex].isFaceUp = false
                //}// all cards set back to face down
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        return score
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card,card]
        }
        
        for _ in cards.indices{
            let r1 = Int(arc4random_uniform(UInt32(cards.count)))
            let r2 = Int(arc4random_uniform(UInt32(cards.count)))
            cards.swapAt(r1,r2)
        }
        
        // TODO: Shuffle Cards
    }
}
