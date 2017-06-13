class TriviaController < ApplicationController
	def index

	end

	def show
		response = HTTParty.get('https://opentdb.com/api.php?amount=10&category=15&type=boolean')

		gon.trivia = response.body
	end
end
