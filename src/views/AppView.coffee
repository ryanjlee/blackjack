class window.AppView extends Backbone.View
  template: _.template '
    <div class="dealer-hand-container"></div>
    <div class="player-hand-container"></div>
    <button class="hit-button btn btn-lrg btn-info">Hit</button> <button class="stand-button btn btn-lrg btn-warning">Stand</button>
  '

  events:
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .hit-button': -> @model.get('playerHand').hit()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el

