class YouTubeControllerController < ApplicationController

  def index
  end

  def show
  end

  def search
    @keyWord = params[:keyWord]
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
        end
     end
    puts $videos[1]

    @data = response['items'][0]['id']['videoId']
    @data1 = response['items'][1]['id']['videoId']
    @data2 = response['items'][2]['id']['videoId']



  end

end

