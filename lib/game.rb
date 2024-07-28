# frozen_string_literal: true

require_relative 'wordlist'
require_relative 'player'

# game controller
class Game
  WORDLIST = WordList.new
  def initialize
    @attempts = 7
    @word = WORDLIST.random_word
    @player = Player.new(@word.length)
    @used_letter = []
    @additional_msg = nil
  end

  def start # rubocop:disable Metrics/MethodLength
    while @attempts.positive?

      display(@additional_msg, 'input a letter:')
      save_game

      input = gets.chomp.upcase
      next unless valid? input

      @player.guess(input, @word)
      next unless @word == @player.word

      display 'congratulations! you won'
      break
    end
    return unless @attempts.zero?

    display "the answer should be #{@word}. game over"
  end

  def save_game
    File.write('data/save_game', Marshal.dump(self))
  end

  def self.load_game(file)
    File.open(file, 'rb') { |data| Marshal.load(data).start }
  end

  private

  def display(*msgs)
    system 'clear'
    puts <<~HEREDOC
      attempts: #{'❤' * @attempts}
      used letters: #{@used_letter.join(' ')}

      #{@player.word.split('').join(' ')}

      messages: #{msgs.filter { |msg| !msg.nil? }.join('. ')}
    HEREDOC
  end

  def valid?(input)
    return false if used?(input)

    @used_letter.push input

    return false unless included? input

    @additional_msg = nil
    true
  end

  def used?(letter)
    return false unless @used_letter.include? letter

    @additional_msg = "that letter, #{letter}, have been used"
    true
  end

  def included?(letter)
    return true if @word.include? letter

    @additional_msg = 'none of such letter in the word'
    @attempts -= 1
    false
  end
end
