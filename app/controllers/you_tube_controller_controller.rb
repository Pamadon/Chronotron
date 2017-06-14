class YouTubeControllerController < ApplicationController

  def index
  end

  def show
  end

  def search
    if ($time)
      @wastetime = $time.to_i
    else
      @wastetime = 60
    end
    if (params[:keyWord])
       @keyWord = params[:keyWord]
    else
      @keyWord = $video_search
    end

    if (params[:length] == "short")
      @time =  "short"
    elsif (params[:length] == "medium")
      @time = "medium"

    elsif (params[:length] == "long")
      @time = "long"
    else
      @time = "any"
    end
    if (params[:numberVideos])
      @numberOf = (params[:numberVideos])
    else
      @numberOf = 5
    end
      # @numberVideos = params[:numberVideos]
      puts @keyWord
      puts @time
      response = HTTParty.get('https://www.googleapis.com/youtube/v3/search?', {
        query: {
            part: 'snippet',
            maxResults: @numberOf,
            order: 'relevance',
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
    end

  def tubeSearch
    @disable_nav = true
    response1 = HTTParty.get('https://www.googleapis.com/youtube/v3/search?', {
      query: {
          part: 'snippet',
          maxResults: '5',
          order: 'relevance',
          q: 'Top music videos',
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

