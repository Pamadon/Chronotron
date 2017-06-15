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
		@responseCode = nil

		while @responseCode != 0 do
			response = HTTParty.get('https://opentdb.com/api.php?', {
				query: {
					amount: @amount,
					category: $category,
					difficulty: $difficulty,
				}
			})

			@responseCode = (JSON.parse(response.body))["response_code"]
			@amount = @amount - 5
		end

		gon.trivia = response.body
	end

end


