class YouTubeControllerController < ApplicationController

  def index
  end

  def show
  end

  def search
    @keyWord = params[:keyword]
    @time = params[:time]
    @numberVideos = params[:numberVideos]
    puts @keyWord
    response = HTTParty.get('https://www.googleapis.com/youtube/v3/search?', {
      query: {
          part: 'snippet',
          maxResults: @numberVideos,
          order: 'relevance',
          q: $video_search,
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
  end

  def tubeSearch


    response1 = HTTParty.get('https://www.googleapis.com/youtube/v3/search?', {
      query: {
          part: 'snippet',
          maxResults: '5',
          order: 'relevance',
          q: 'dogs',
          type: 'video',
          videoDuration: 'short',
          videoEmbeddable: 'true',
          key: 'AIzaSyB9vzAQ4Nn-Ig3fzaRdDEO0zptnI85vPSM'
          }
    })
    $relatedV = []
    if response1.code == 200
      @results = JSON.parse(response1.body)
        for item in  @results['items']
        $relatedV.push(item['id']['videoId'])

        end
     end
    puts $relatedV
  end

end

