class YouTubeControllerController < ApplicationController
  def search
    gon.choice = $choice
    if ($time)
      @wastetime = $time.to_i
    else
      @wastetime = 60
    end
      response = HTTParty.get('https://www.googleapis.com/youtube/v3/search?', {
        query: {
            part: 'snippet',
            maxResults: $numberVideos,
            order: 'relevance',
            q: $video_search,
            type: 'video',
            videoDuration: $video_length,
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
          maxResults: '3',
          order: 'relevance',
          q: $genre,
          type: 'video',
          videoDuration: 'long',
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

