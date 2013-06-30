#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  defaults:
    "gameWon" : false
    "winner"  : '_house'

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @player = @get('playerHand')
    @dealer = @get('dealerHand')

    #TODO: refactor win and lose and stand triggers to be source-agnostic

    @player.on "lose", =>
      @declareWinner(@dealer)

    @dealer.on "lose", =>
      @declareWinner(@player)

    @player.on "stand", =>
      @dealerBehavior()

    @dealer.on "stand", =>
      @establishWinner()
    ## --------------------------

    @player.on "all", =>
      @trigger 'render'

  dealerBehavior: ->
    @dealer.dealerPlay()
    @dealer.reveal();
    @establishWinner();

  establishWinner: ->
    if @player.overN(21)
      @declareWinner(@dealer)

    if @dealer.overN(21)
      @declareWinner(@player)

    if @player.bestScore() > @dealer.bestScore()
      @declareWinner(@player);
    else
      @declareWinner(@dealer);

  declareWinner: (winner) ->
    @set 'gameWon', true
    @set 'winner', winner.getName()
