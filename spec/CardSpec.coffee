describe "hand constructor", ->

  deck = null
  hand = null

  beforeEach ->

    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hand', ->

    it 'should begin with two cards', ->
      expect(hand.length).toBe 2

    it 'should be associated with deck', ->
      expect(hand.deck).toBe deck

    it 'should belong to dealer or player', ->
      expect(typeof hand.isDealer).toBe("boolean")

    it 'should have another card after hit', ->
      hand.hit()
      expect(hand.length).toBe 3
      hand.hit()
      hand.hit()
      expect(hand.length).toBe 5

  describe 'dealer hand', ->
    beforeEach ->
      hand = deck.dealDealer()

    it 'first card should not be initially revealed', ->
      expect(hand.models[0].get('revealed')).toBe false

    it 'should flip the first card if revealed', ->
      hand.reveal()
      expect(hand.models[0].get('revealed')).toBe true

  describe 'hit', ->
    it 'should call lose if score goes over 21', ->
      spyOn(Hand.prototype, 'lose').andCallThrough()
      spyOn(Hand.prototype, 'bestScore').andReturn(-1)
      deck = new Deck()
      hand = deck.dealPlayer()
      hand.hit()
      expect(hand.lose).toHaveBeenCalled()

  describe 'stand', ->
    it 'should trigger stand', ->
      spyOn(Hand.prototype, 'trigger').andCallThrough()
      deck = new Deck()
      hand = deck.dealPlayer()
      hand.stand()
      expect(hand.trigger).toHaveBeenCalled()

  describe 'helpers', ->

    it 'should return true if score over some n', ->
      fakeCardData1 =
          rank: 1
      fakeCardData2 =
          rank: 6

      hand = new Hand([fakeCardData1, fakeCardData2])
      expect(hand.overN(17)).toBe false
      console.log(hand.overN(17))
      fakeCardData3 =
          rank: 10

      hand = new Hand([fakeCardData1, fakeCardData2, fakeCardData3])
      expect(hand.overN(17)).toBe false

      fakeCardData4 =
          rank: 10
      console.log(hand)
      hand = new Hand([fakeCardData1, fakeCardData2, fakeCardData3, fakeCardData4])
      expect(hand.overN(17)).toBe true


    it 'should identify bestscore', ->
      fakeCardData1 =
          rank: 1

      hand = new Hand([fakeCardData1, fakeCardData1, fakeCardData1])
      expect(hand.bestScore()).toBe 13
