# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('stand', => @playDealer()) # look at this later
    @get('playerHand').on('hit', => @checkPlayerHand())
    $(document).ready(=>
      if @get('playerHand').scores()[1] is 21
        @playDealer(true))

  playDealer: (autowin) ->
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

    computerScore = checkHand(computerHand.scores()[1])

    if @get('playerHand').scores()[1] <= 21
      playerScore = @get('playerHand').scores()[1]
    else
      playerScore = @get('playerHand').scores()[0]

    $('button').remove()
    $('body').append('<button class="btn btn-lrg btn-primary play-again">Play again?</button>');
    $('.play-again').on('click', ->location.reload())
    notify = $('<div class="winner"></div>').text(@endGame(playerScore,computerScore,autowin));
    $('body').append(notify)

  checkPlayerHand: ->
    humanHand = @get('playerHand')
    if humanHand.scores()[1] is 21 or humanHand.scores()[0] is 21
      @playDealer()
    if humanHand.scores()[1] > 21 and humanHand.scores()[0] > 21
      @playDealer()


  endGame: (playerScore, computerScore, autowin) ->
    if autowin
      return result = 'You win'
    if playerScore > 21
      return result = 'You lose'
    if computerScore > 21
      return result = 'You win'
    if playerScore > computerScore
      return result = 'You win'
    if computerScore > playerScore
      return result = 'You lose'
    if computerScore is playerScore
      return result = 'Push'




