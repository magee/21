describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()

  describe 'hit', ->
    beforeEach ->
      hand = deck.dealPlayer()

    it 'should give the last card from the deck', ->
      expect(deck.length).toBe 50
      expect(deck.last()).toEqual hand.hit()
      expect(deck.length).toBe 49
      expect(deck.last()).toEqual hand.hit()
      expect(deck.length).toBe 48

  describe 'card counts in shoes', ->
    it 'should have 52 cards in 1 deck shoe', ->
      expect(deck.length).toBe 52

    it 'should have 52 cards for each deck in shoe', ->
      deck = new Deck()
      deck.addMoreDecks(1)
      expect(deck.length).toBe 104
      deck = new Deck
      deck.addMoreDecks(9)
      expect(deck.length).toBe 520
