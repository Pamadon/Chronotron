class TriviaController < ApplicationController
	def index
	end

	def show
		response = HTTParty.get('https://opentdb.com/api.php?', {
			query: {
				amount: '50',
				category: $category,
				difficulty: $difficulty,
			}
		})

		gon.trivia = response.body
	end

end


