class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer=false) ->
    if @isDealer
      @handName = "Dealer"
    else
      @handName = "Player"

  getName: ->
    return @handName

  hit: ->
    # addition of flipping behavior on hit has circumvented score calculations
    # @trigger 'resetNew', @   # if comment this line out previous card flips back over
    newCard = @deck.pop().flip()
    newCard.set('newCard', true)
    @add(newCard).last()
    if @bestScore() is -1 then @lose()
    newCard

  stand: ->
    @trigger 'stand', @

  lose: ->
    @trigger 'lose', @

  dealerPlay: ->
    while !@overN(17)
      @hit()
    @stand();

  overN: (n) ->
    lowest = @scores('internal')[0]
    for item in @scores('internal')
      if item < lowest then lowest = item
    if lowest > n then return true
    return false

  bestScore: ->
    highest = -1
    for item in @scores('internal')
      if item <= 21 and item > highest
       highest = item
    return highest

  scores: (internal) ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false

    score = @reduce (score, card) ->
      if internal
        score + card.get 'value';
      else
        score + if card.get 'revealed' then card.get 'value' else 0
    , 0

    if hasAce then [score, score + 10] else [score]

  reveal: ->
    @models[0].flip()
    @trigger 'reveal', @
