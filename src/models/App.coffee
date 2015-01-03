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
    checkingMin = false
    checkHand = (score) ->
      console.log('Max: ' + computerHand.scores()[1] + ' Min: ' + computerHand.scores()[0])
      if score >= 17 and score <= 21
        return score
      if score < 17
        computerHand.hit()
        if checkingMin
          return checkHand(computerHand.scores()[0])
        else
          return checkHand(computerHand.scores()[1])
      if score > 21 and not checkingMin
        checkingMin = true
        return checkHand(computerHand.scores()[0])
      else
        return score

    checkHand(computerHand.scores()[1])
