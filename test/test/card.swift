import Foundation
struct Card:Hashable{
    var hashValue: Int{
        return identifier
    }
    //func hash(into:hasher)
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var isFlited = false
    private var identifier: Int
    static var idFactory = 0
    
    
    static func getUniqueIdentifier() -> Int{
        idFactory += 1
        return idFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
