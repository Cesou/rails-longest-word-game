require 'open-uri'
require 'json'

class LongestwordsController < ApplicationController

  def game
    @start_time = Time.now.to_i
    @grid = generate_grid(9)
  end

  def score
    @start_time = params[:at_time].to_i
    @end_time = Time.now.to_i
    @input = params[:answer]
    @time_values = time_taken(@end_time, @start_time)
    if english_word?(@input) == false
      @answer = "Sad !This is not an english word"
      @score = 0
    else
      @answer = " Congratulations ! This is an english word!"
      @score = calculate_score(@time_values, @input)
    end
  end

  private

  def generate_grid(grid_size)
    grid = Array.new(grid_size) { ('A'..'Z').to_a.sample }
    grid.join(" ")
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    JSON.parse(response.read)['found']
  end

  def time_taken (end_time, start_time)
    end_time - start_time
  end

  def calculate_score (time, input)
   time > 60.0 ? 0 : input.length * (1.0 - time / 60.0)
  end

  # def compute_score(attempt, time_taken)
  #   time_taken > 60.0 ? 0 : attempt.size * (1.0 - time_taken / 60.0)
  # end

end


