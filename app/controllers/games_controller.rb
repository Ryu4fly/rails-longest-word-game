class GamesController < ApplicationController
  def new
    @letters = [* 'A'...'Z'].sample(10).join(' ')
    @start_time = Time.now
    raise
  end

  def score
    @response = params[:reponse]
  end
end
