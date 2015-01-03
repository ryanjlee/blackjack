# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('stand', => @playDealer()) # look at this later

  playDealer: ->
    computerHand = @get('dealerHand')
    computerHand.at(0).flip()
    checkHand = (score) ->
      if score => 17 and score =< 21
        console.log('You lose!')
        return score
      if computerHand.scores()[0] > 21
        console.log('You win')
        return score
      if score < 17
        computerHand.hit()
        checkHand (score)
      if score > 21
        checkHand (computerHand.scores()[0])
    checkHand computerHand.scores()[1]

    # if @get('dealerHand').scores()[1] < 17
    #   @get('dealerHand').hit()
    # else if @get('dealerHand').scores()[1] > 21
    #   if @get('dealerHand').scores()[0] < 17
    #     @get('dealerHand').hit()
    # else console.log('Yeah!')

