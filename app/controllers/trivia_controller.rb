class TriviaController < ApplicationController
	def index

	end

	def show
		require 'htmlentities'
		coder = HTMLEntities.new

		response = HTTParty.get('https://opentdb.com/api.php?amount=10&category=15&type=boolean')

		gon.trivia = response.body
	end
end
