class TriviaController < ApplicationController
	def index
	end

	def show
		if $time == '5'
			@amount = 25
		else
			@amount = 50
		end

		gon.amount = @amount
		gon.category = $category
		gon.difficulty = $difficulty

		response = HTTParty.get('https://opentdb.com/api.php?', {
			query: {
				amount: 1,
				category: $category,
				difficulty: $difficulty,
			}
		})

		# response = HTTParty.get('https://opentdb.com/api.php?', {
		# 	query: {
		# 		amount: @amount,
		# 		category: $category,
		# 		difficulty: $difficulty,
		# 	}
		# })

		gon.trivia = response.body
	end

end


