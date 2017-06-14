class TriviaController < ApplicationController
	def index
	end

	def show
		# response = HTTParty.get('https://opentdb.com/api.php?', {
		# 	query: {
		# 		amount: ,
		# 		category: ,
		# 		difficulty: ,
		# 	}
		# })

		response = HTTParty.get('https://opentdb.com/api.php?amount=10&type=multiple')

		gon.trivia = response.body
	end

end


