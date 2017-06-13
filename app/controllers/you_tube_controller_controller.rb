class YouTubeControllerController < ApplicationController

  def index


  end


  def show

    videos = Yt::Collections::Videos.new
    puts videos.inspect
    puts videos.where()

 # 	response = HTTParty.get("https://www.googleapis.com/youtube/v3/search?part=snippet&q=lady+-gaga&key=AIzaSyB9vzAQ4Nn-Ig3fzaRdDEO0zptnI85vPSM'", {
	# 	query: {term: params['search']['query']}
	# })
	# 	@data = nil
	# 	if response.code == 200
	# 		@data = JSON.parse(response.body)
 #  end
  end
  def search
    @keyWord = params[:keyWord]
    puts @keyWord
    response = HTTParty.get('https://www.googleapis.com/youtube/v3/search?', {
      query: {
         part: 'snippet',
          maxResults: '3',
          order: 'rating',
          q: @keyWord,
          type: 'video',
          videoDuration: 'short',
          videoEmbeddable: 'true',
          key: 'AIzaSyB9vzAQ4Nn-Ig3fzaRdDEO0zptnI85vPSM'
          }
  })
    @data = response['items'][0]['id']['videoId']

  end

end

