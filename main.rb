# frozen_string_literal: true

require_relative 'lib/game'

def handle_answer
  response = gets.chomp.upcase

  if response == 'Y'
    Game.load_game('data/save_game.marshal')
  elsif response == 'N'
    Game.new.start
  else
    handle_answer
  end
end

if File.exist? 'data/save_game'
  puts <<-HEREDOC
    Save file from previous game is found.
    Would you like to load it? y/n
  HEREDOC
  handle_answer
else
  Game.new.start
end
