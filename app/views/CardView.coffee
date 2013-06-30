class window.CardView extends Backbone.View

  className: 'container'

  icons =
    Spades : '<span class="symbol black">&#9824;</span>';
    Diamonds : '<span class="symbol red">&#9830;</span>';
    Hearts : '<span class="symbol red">&#9829;</span>';
    Clubs : '<span class="symbol black">&#9827;</span>';

  template: _.template '<div id="card"><figure class="front"><div class="cardName"><%= rankName %> </figure><figure class="back"></figure>'

  initialize: ->
    @model.on 'reveal', => @flip()
    # @model.on 'change', => @render()   # doesn't appear to have any effect on code
    @render()

  flip: ->
    @$el.removeClass 'flipped'

  render: ->
    console.log(@model.get 'newCard')

    @$el.children().detach().end().html
    @$el.html @template @model.attributes
    @$el.find('.front').append(icons[@model.get('suitName')])
    @$el.find('#card').addClass 'flipped' unless @model.get 'revealed'

    delay = (ms, func) -> setTimeout func, ms
    delay 200, =>
      if @model.get ('newCard')
        @$el.find('#card').removeClass 'flipped'

  # add logic to listen for reveal to flip the first card