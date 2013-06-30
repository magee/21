class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    # these work:
    "click .hit-button"  : -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()


  initialize: ->
    @render()
    @model.on "all", =>
      @render()

  render: ->
    console.log('running render')
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    if @model.get('gameWon')
      name = @model.get("winner")
      @$el.append "<br /><div class='notice'>Game Over - #{ name } won!</div>"
