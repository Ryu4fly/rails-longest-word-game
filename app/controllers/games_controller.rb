require 'open-uri'

class GamesController < ApplicationController

  def new
    @grid_letters = [* 'A'...'Z'].sample(10).join(' ')
    @start_time = Time.now
  end

  def score
    @grid_letters = params[:letters]
    @response = params[:response]
    @end_time = Time.now
    @duration = @end_time - params[:start].to_time
    @result = result(@response)
  end

  private

  def scraper(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized_word = open(url).read
    JSON.parse(serialized_word)
  end

  def valid?(response)
    response_letters = response.upcase.split('')

    unacceptable = []

    response_letters.each do |letter|
      unacceptable << letter unless @grid_letters.include?(letter)
    end

    unacceptable
  end

  def result(response)
    is_valid = valid?(response.upcase)
    word = scraper(response.downcase)

    if !is_valid.empty?
      "Letters \'#{is_valid.join(',')}\' can't be used"
    elsif word[:found] == 'false'
      "#{response} is not a word/English word"
    else
      'Well Done!'
    end
  end

end
