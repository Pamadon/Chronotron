class YouTubeControllerController < ApplicationController

  def index
  end

  def show
  @keyWord =
	response = HTTParty.get('https://www.googleapis.com/youtube/v3/search?part=snippet&q=french+lessons&key=AIzaSyB9vzAQ4Nn-Ig3fzaRdDEO0zptnI85vPSM')

	puts response.body, response.code, response.message, response.headers.inspect

 # 	response = HTTParty.get("https://www.googleapis.com/youtube/v3/search?part=snippet&q=lady+-gaga&key=AIzaSyB9vzAQ4Nn-Ig3fzaRdDEO0zptnI85vPSM'", {
	# 	query: {term: params['search']['query']}
	# })
	# 	@data = nil
	# 	if response.code == 200
	# 		@data = JSON.parse(response.body)
 #  end
end
  def search
  end


end
