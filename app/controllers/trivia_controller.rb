class TriviaController < ApplicationController
	def index

	end

	def show
		require 'htmlentities'
		coder = HTMLEntities.new

		response = HTTParty.get('https://opentdb.com/api.php?amount=1&category=15&type=boolean')

		gon.trivia = coder.decode(response["results"][0]["question"])
	end
end
