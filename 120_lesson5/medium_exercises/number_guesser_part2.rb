class Game
  attr_accessor :remaining_guesses

  def initialize(start_num, end_num)
    @start_num = start_num
    @end_num = end_num
    @size_of_range = (@end_num - @start_num)
  end

  def find_number_of_guesses
    @number_of_guesses = Math.log2(@size_of_range).to_i + 1
  end

  def play
    find_number_of_guesses
    @random_number = (@start_num..@end_num).to_a.sample
    @remaining_guesses = @number_of_guesses
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
    puts "Enter a number between #{@start_num} and #{@end_num}:"
    loop do
      answer = gets.chomp.to_i
      break if valid_input?(answer)
      puts "Sorry, that's not a valid response."
    end
    @answer = answer
  end

  def valid_input?(answer)
    answer < @end_num && answer > @start_num
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

game = Game.new(501, 1500)

game.play
