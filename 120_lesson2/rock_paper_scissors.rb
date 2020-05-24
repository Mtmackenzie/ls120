class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, #{human.name}!"
  end

  def display_goodbye_message
    puts "Thanks for playing! Goodbye!"
  end

  def compare_moves
    winning_moves = {'rock' => 'scissors', 'scissors' => 'paper', 'paper' => 'rock'}
    if human.move == computer.move
      "It's a tie!"
    elsif winning_moves[human.move] == computer.move
      "#{human.name} won!"
    else
      "#{computer.name} won!"
    end
  end

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    puts compare_moves
  end

  def play_again?
    puts "Would you like to play again? Type Y if yes."
    answer = gets.chomp
    return true if answer.downcase == 'y'
    false
  end
end

class Player
  attr_accessor :move, :name
  def initialize
    set_name
  end


  def human?
    @player_type == :human
  end
end

class Human < Player
  def set_name
    n = ''
      loop do
        puts "What's your name?"
        n = gets.chomp
        break unless n.empty?
        puts "Sorry, must enter a value."
      end
      self.name = n.capitalize
  end

  def choose
    choice = nil
      loop do
        puts "Please choose rock, paper, or scissors:"
        choice = gets.chomp
        break if ['rock', 'paper', 'scissors'].include?(choice)
        puts "Sorry, invalid input. Try again."
      end
      self.move = choice
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Siri', 'Alexa'].sample
  end

  def choose
    self.move = ['rock', 'paper', 'scissors'].sample
  end
end

RPSGame.new.play