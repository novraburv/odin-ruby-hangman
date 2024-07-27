# frozen_string_literal: true

require_relative 'wordlist'
require_relative 'player'

# game select random word from wordlist
# measure word length
# make input field and game progress, including attempts left
#   max attempts is 7
# save guesses in guess class
# evaluate
# repeat

# game controller
class Game
  WORDLIST = WordList.new
  def initialize
    @attempts = 7
    @word = WORDLIST.random_word
    @player = Player.new(@word.length)
    @used_letter = []
  end

  def start
    while @attempts.positive?
      puts <<-HEREDOC
      ❤: #{@attempts}
      used letters: #{@used_letter.join(' ')}

      #{@player.word.split('').join(' ')}
      insert your guess:
      HEREDOC

      input = gets.chomp.upcase
      @used_letter.push input

      unless @word.include? input
        system 'clear'
        puts 'none of such things in the word'
        @attempts -= 1
        next
      end

      @player.guess(input, @word)

      next unless @word == @player.word

      system 'clear'
      puts 'you won'
      break
    end
    return unless @attempts.zero?

    puts <<-HEREDOC
      answer should be #{@word}
      game over!
    HEREDOC
  end
end

# notes:
#   add features to save and load game with serialization
