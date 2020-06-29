class Game
  attr_accessor :remaining_guesses

  def play
    @random_number = (1..100).to_a.sample
    @remaining_guesses = 7
    @answer = nil
    @game_over = false
    system 'cls'
    main_game_loop
  end

  def main_game_loop
    loop do
      display_remaining_guesses
      guess
      guess_result
      break if game_over?
    end
    puts "Goodbye!"
  end

  def display_remaining_guesses
    puts "Remaining guesses: #{remaining_guesses}."
  end

  def guess
    answer = nil
    puts "Enter a number between 1 and 100:"
    loop do
      answer = gets.chomp.to_i
      break if valid_input?(answer)
      puts "Sorry, that's not a valid response."
    end
    @answer = answer
  end

  def valid_input?(answer)
    answer < 100 && answer > 1
  end

  def guess_result
    won? ? won : continue_or_end_game
  end

  def game_over?
    @game_over
  end

  def won?
    @answer == @random_number
  end

  def won
    display_win_message
    @game_over = true
  end

  def continue_or_end_game
    if @remaining_guesses > 1
      display_guess_comparison_hint
      @remaining_guesses -= 1
    else
      display_guess_comparison_hint
      display_lose_message
      @game_over = true
    end
  end

  def display_guess_comparison_hint
    if @answer > @random_number
      puts "Your guess is too high."
    else
      puts "Your guess is too low."
    end
  end

  def display_win_message
    puts "That's the number! You won!"
  end

  def display_lose_message
    puts "You have no more guesses. You lost!"
  end
end

game = Game.new

game.play
game.play
