class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    #TODO: why doesn't 'add' trigger 'change'?

    #these work:
    # @collection.on 'change', => @render
    @collection.on 'add', =>
      @render

    @collection.on 'lose', =>
      if @collection.isDealer
       @trigger('playerWin', @)
      else
       @trigger('dealerWin', @)

    @collection.on 'resetNew', =>
      @collection.map (card) ->
        card.set('newCard', false)
        # if I comment out hand.coffee line 15 it doesnt resets newCard and all hits flip again
        # if I don't, only the latest card flips on each subsequent hit but the previous
        # hit returns to lying face down

    @render()


  render: ->
    @$el.children().detach
    @$el.html(@template @collection).append @collection.map (card) -> new CardView(model: card).el
    @$('.score').text @collection.scores()[0]
