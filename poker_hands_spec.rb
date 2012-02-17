#require 'poker_hands'

describe "PokerHands" do
  describe "Game: higher card" do
    it "should compare 2,3,4,5,6 and 2,3,4,6,7 
        and tell 2,3,4,6,7 is higher" do
      hand1 = [2,3,4,5,6]
      hand2 = [2,3,4,6,7]
      higher(hand1, hand2).should == hand2
    end
    
    it "should compare 2,3,4,6,7 and 2,3,4,5,6 
        and tell 2,3,4,6,7 is higher" do
      hand1 = [2,3,4,6,7]
      hand2 = [2,3,4,5,6]
      higher(hand1, hand2).should == hand1
    end

    it "should compare 2,3,4,6,7 and 2,3,4,5,6 
        and tell 2,3,4,6,7 is higher" do
      hand1 = [2,3,4,5,7]
      hand2 = [2,3,4,6,7]
      higher(hand1, hand2).should == hand2
    end

    it "should compare second higher when there is a 
        draw" do
      hand1 = [2,3,4,6,7]
      hand2 = [2,3,4,5,7]
      higher(hand1, hand2).should == hand1
    end
    
    it "should compare until first higher when a draw is set" do
      hand1 = [4,3,2,9,8]
      hand2 = [3,3,4,9,8]
      higher(hand1, hand2).should == hand2
    end
  end

  describe "game: pairs" do
    it "pair vs high card, pair wins" do
      hand1 = [2,2,6,7,8]
      hand2 = [9,8,7,6,4]
      higher(hand1, hand2).should == hand1
    end
    
    it "pair vs high card, pair wins" do
      hand1 = [3,2,6,7,8]
      hand2 = [2,3,7,7,4]
      higher(hand1, hand2).should == hand2
    end
    
    it "should contains a pair" do
      hand1 = [2,2,6,7,8]
      has_pair(hand1).should == true
    end
    it "should not contains a pair" do
      hand1 = [5,2,6,7,8]
      has_pair(hand1).should == false
    end
    
  end
end
def higher(hand1, hand2)
  working_hand1 = hand1.sort
  working_hand2 = hand2.sort
  
  if hand1.count(2) == 2
    return hand1 
  end
  
  if hand2.count(7) == 2
    return hand2 
  end
  
  card1, card2 = last_cards(working_hand1, working_hand2)
  counter = 4
  while card1 == card2
    card1 = working_hand1[counter]
    card2 = working_hand2[counter]
    counter = counter - 1
  end

  return hand2 if card1 < card2
  hand1
end

def last_cards(hand1, hand2)
  [hand1.last, hand2.last]
end

def has_pair(hand)
  hand.find{|card| hand.count(card)==2} != nil
end