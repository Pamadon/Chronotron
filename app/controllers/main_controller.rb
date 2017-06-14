class MainController < ApplicationController
    def index
    	@disable_nav = true

      $categories = [
        ["Any", nil],
        ["General Knowledge", "9"],
        ["Books", "10"],
        ["Film", "11"],
        ["Music", "12"],
        ["Musicals & Theatre", "13"],
        ["Television", "14"],
        ["Japanese Anime & Manga", "31"],
        ["Cartoons & Animations", "32"],
        ["Comics", "29"],
        ["Video Games", "15"],
        ["Board Games", "16"],
        ["Science & Nature", "17"],
        ["Computers", "18"],
        ["Mathematics", "19"],
        ["Gadgets", "30"],
        ["Mythology", "20"],
        ["Sports", "21"],
        ["Geography", "22"],
        ["History", "23"],
        ["Politics", "24"],
        ["Art", "25"],
        ["Celebrities", "26"],
        ["Animals", "27"],
        ["Vehicles", "28"]]

      $difficulties = [
        ["Any", nil],
        ["Easy", "easy"],
        ["Medium", "medium"],
        ["Hard", "hard"]]

      $genres = [
        ["acoustic", "acoustic"], ["afrobeat", "acoustic"], ["alt-rock", "alt-rock"], ["alternative", "alternative"], ["ambient", "ambient"], ["anime", "anime"], ["black-metal", "black-metal"], ["bluegrass", "bluegrass"], ["blues", "blues"], ["bossanova", "bossanova"], ["brazil", "brazil"], ["breakbeat", "breakbeat"], ["british", "british"], ["cantopop", "cantopop"], ["chicago-house", "chicago-house"], ["children", "children"], ["chill", "chill"], ["classical", "classical"], ["club","club"], ["comedy", "comedy"], ["country", "country"], ["dance", "dance"], ["dancehall", "dancehall"], ["death-metal", "death-metal"], ["deep-house", "deep-house"], ["detroit-techno", "detroit-techno"], ["disco", "disco"], ["disney", "disney"], ["drum-and-bass", "drum-and-bass"], ["dub", "dub"], ["dubstep", "dubstep"], ["edm", "edm"], ["electro", "electro"], ["electronic", "electronic"], ["emo", "emo"], ["folk", "folk"], ["forro", "forro"], ["french", "french"], ["funk", "funk"], ["garage", "garage"], ["german", "german"], ["gospel", "gospel"], ["goth", "goth"], ["grindcore", "grindcore"], ["groove", "groove"], ["grunge", "grunge"], ["guitar","guitar"], ["happy", "happy"], ["hard-rock", "hard-rock"], ["hardcore", "hardcore"], ["hardstyle", "hardstyle"], ["heavy-metal", "heavy-metal"], ["hip-hop", "hip-hop"], ["holidays","holidays"], ["honky-tonk", "honky-tonk"], ["house", "house"], ["idm", "idm"], ["indian", "indian"], ["indie", "indie"], ["indie-pop", "indie-pop"], ["industrial", "industrial"], ["iranian", "iranian"], ["j-dance", "j-dance"], ["j-idol", "j-idol"], ["j-pop", "j-pop"], ["j-rock", "j-rock"], ["jazz", "jazz"], ["k-pop", "k-pop"], ["kids","kids"], ["latin", "latin"], ["latino", "latino"], ["malay", "malay"], ["mandopop", "mandopop"], ["metal", "metal"], ["metal-misc", "metal-misc"], ["metalcore","metalcore"], ["minimal-techno", "minimal-techno"], ["movies", "movies"], ["mpb","mpb"], ["new-age", "new-age"], ["new-release","new-release"], ["opera","opera"], ["pagode","pagode"], ["party","party"], ["philippines-opm","philippines-opm"], ["piano", "piano"], ["pop", "pop"], ["pop-film","pop-film"], ["post-dubstep","post-dubstep"], ["power-pop", "power-pop"], ["progressive-house","progressive-house"], ["psych-rock","psych-rock"], ["punk","punk"], ["punk-rock", "punk-rock"], ["r-n-b","r-n-b"], ["rainy-day","rainy-day"], ["reggae","reggae"], ["reggaeton","reggaeton"], ["road-trip","road-trip"], ["rock","rock"], ["rock-n-roll", "rock-n-roll"], ["rockabilly","rockabilly"], ["romance", "romance"], ["sad", "sad"], ["salsa","salsa"], ["samba","samba"], ["sertanejo","sertanejo"], ["show-tunes","show-tunes"], ["singer-songwriter", "singer-songwriter"], ["ska","ska"], ["sleep","sleep"], ["songwriter", "songwriter"], ["soul", "soul"], ["soundtracks", "soundtracks"], ["spanish", "spanish"], ["study", "study"], ["summer", "summer"], ["swedish", "swedish"], ["synth-pop", "synth-pop"], ["tango","tango"], ["techno","techno"], ["trance", "trance"], ["trip-hop","trip-hop"], ["turkish","turkish"], ["work-out", "work-out"], ["world-music","world-music"]]
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
