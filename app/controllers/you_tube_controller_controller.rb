class YouTubeControllerController < ApplicationController

  def index
    def search_list_by_keyword(service, part, **params)
  params = params.delete_if { |p, v| v == ''}
  response = service.list_searches(part, params)
  print_results(response)
end

search_list_by_keyword(service, 'snippet',
  max_results: 25,
  q: 'surfing',
  type: '')
  end

  def show

 videos = Yt::Collections::Videos.new
 puts videos.where(order: 'viewCount').first.title
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
  response = HTTParty.get('https://www.googleapis.com/youtube/v3/search?part=snippet&key=AIzaSyB9vzAQ4Nn-Ig3fzaRdDEO0zptnI85vPSM', {

  })
  puts response
  end


end

