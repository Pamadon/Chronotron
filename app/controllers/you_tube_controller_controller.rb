class YouTubeControllerController < ApplicationController

  def index
  end

  def show
  end

  def search
    @keyWord = params[:keyWord]
    if $time.to_i <= 20
      @time == 'short'
    end
    @time = params[:time]
    @numberVideos = params[:numberVideos]
    puts @keyWord
    response = HTTParty.get('https://www.googleapis.com/youtube/v3/search?', {
      query: {
          part: 'snippet',
          maxResults: @numberVideos,
          order: 'rating',
          q: @keyWord,
          type: 'video',
          videoDuration: @time,
          videoEmbeddable: 'true',
          key: 'AIzaSyB9vzAQ4Nn-Ig3fzaRdDEO0zptnI85vPSM'
          }
  })
    $videos = []
    if response.code == 200
      @video_result = JSON.parse(response.body)
        for item in  @video_result['items']
        $videos.push(item['id']['videoId'])
        puts @video_result
        end
     end
    puts $videos[1]
  end

end

