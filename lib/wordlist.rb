# frozen_string_literal: true

# as implied by its name
class WordList
  FILE_NAME = 'data/google-10000-english-no-swears.txt'
  DL_LINK = 'https://raw.githubusercontent.com/first20hours/google-10000-english/master/google-10000-english-no-swears.txt'
  attr_reader :wordlist

  def initialize
    download unless File.exist? FILE_NAME
    @wordlist = load_file FILE_NAME
  end

  def random_word
    wordlist.sample.upcase
  end

  def update
    system "rm #{FILE_NAME}"
    download
    self.wordlist = load_file FILE_NAME
  end

  private

  def download
    system "curl -o #{FILE_NAME} #{DL_LINK}"
  rescue StandardError
    puts "download the wordlist from #{DL_LINK}"
    puts 'load the wordlist inside data/ folder'
  end

  def load_file(file)
    File.readlines(file, chomp: true).select do |word|
      word.length >= 5 && word.length <= 12
    end
  end
end
