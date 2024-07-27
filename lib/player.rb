# frozen_string_literal: true

# create an instance to save player's guess
# guess is an array based on selected word's length
class Player
  attr_reader :word

  def initialize(length)
    @word = String.new.ljust(length, '_')
  end

  def guess(letter, word)
    return unless word.include?(letter)

    # find occurences
    letters = {}
    word.split('').each_with_index do |l, i|
      letters[l] = [] if letters[l].nil?
      letters[l].push(i)
    end

    # update word
    letters[letter].each do |idx|
      @word[idx] = letter
    end
  end
end
