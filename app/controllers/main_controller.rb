class MainController < ApplicationController
    def index
    	@disable_nav = true

      $categories = [
        ["Any", nil],
        ["General Knowledge", "9"], # <50/hard
        ["Books", "10"], # < 25
        ["Film", "11"], # < 25/hard
        ["Music", "12"], # < 50/hard
        ["Television", "14"], # <25/hard < 50
        ["Video Games", "15"],
        ["Board Games", "16"], # < 25
        ["Science & Nature", "17"], # < 50 easy & hard
        ["Computers", "18"], # < 25 hard < 50 easy & hard
        ["Mathematics", "19"], # < 25
        ["Mythology", "20"], # < 25
        ["Sports", "21"], # < 25/hard < 50
        ["Geography", "22"], # < 50 hard
        ["History", "23"], # < 50 easy & hard
        ["Politics", "24"], # < 25
        ["Celebrities", "26"], # < 25
        ["Animals", "27"], # < 25
        ["Vehicles", "28"], # < 25 easy & hard
        ["Comics", "29"], # < 25
        ["Japanese Anime & Manga", "31"], # < 25/hard < 50
        ["Cartoons & Animations", "32"]] # < 25

      $difficulties = [
        ["Any", nil],
        ["Easy", "easy"],
        ["Medium", "medium"],
        ["Hard", "hard"]]

      $genres = [
        ["acoustic", "acoustic"], ["afrobeat", "afrobeat"], ["alt-rock", "alt-rock"],  ["ambient", "ambient"], ["bluegrass", "bluegrass"], ["blues", "blues"], ["chill", "chill"], ["classical", "classical"], ["comedy", "comedy"], ["country", "country"], ["dance", "dance"], ["dancehall", "dancehall"], ["death-metal", "death-metal"], ["dubstep", "dubstep"], ["edm", "edm"],["emo", "emo"], ["folk", "folk"], ["funk", "funk"], ["garage", "garage"],  ["grunge", "grunge"],  ["happy", "happy"], ["hip-hop", "hip-hop"], ["holidays","holidays"], ["house", "house"], ["indian", "indian"], ["indie", "indie"], ["industrial", "industrial"], ["j-pop", "j-pop"], ["jazz", "jazz"], ["latin", "latin"], ["metal", "metal"],  ["new-release","new-release"], ["party","party"], ["pop", "pop"], ["punk","punk"], ["r-n-b","r-n-b"], ["rainy-day","rainy-day"], ["reggae","reggae"], ["road-trip","road-trip"], ["rock","rock"], ["romance", "romance"], ["sad", "sad"], ["show-tunes","show-tunes"], ["singer-songwriter", "singer-songwriter"], ["ska","ska"], ["sleep","sleep"], ["soul", "soul"], ["study", "study"], ["summer", "summer"], ["techno","techno"], ["trance", "trance"], ["trip-hop","trip-hop"], ["work-out", "work-out"], ["world-music","world-music"]]
      $modes = [['driving', 'driving'],['bicycling', 'bicycling'], ['walking','walking']]
    end

    def choice
      $time = params[:time_limit]
      $genre = params[:genre]
      $category = params[:categories]
      $difficulty = params[:difficulties]
      if $category.nil?
        $trivia_category = "Any"
      else
        $trivia_category = find_trivia_category($category)
      end
      if (params[:length] == "short")
        $video_length =  "short"
      elsif (params[:length] == "medium")
        $video_length = "medium"
      elsif (params[:length] == "long")
        $video_length = "long"
      else
        $video_length = "any"
      end
      $numberVideos = params[:numberVideos]
      $video_search = params[:video_query]
      $location = params[:location]
      $mode = params[:mode]


      if params[:music]
        $choice = "music"
        redirect_to '/auth/spotify'
      elsif params[:videos]
        $choice = "videos"
        redirect_to '/you_tube_controller/search'
      elsif params[:trivia]
        $choice = "trivia"
        redirect_to '/trivia'
      elsif params[:trails]
        $choice = "trails"
        redirect_to '/trail/show'
      end
    end
end

# helper function
def find_trivia_category(num)
  if num.empty?
    return "Any"
  end
  for category in $categories do
    if category[1] == num
      return category[0]
    end
  end
end
