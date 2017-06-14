class MusicController < ApplicationController
    before_action :current_user

  def spotify
    @user = RSpotify::User.new(request.env['omniauth.auth'])

    spotify_hash = @user.to_hash

    user = User.find_or_create_by(email: @user.email) do |u|
      u.email = @user.email
      u.spotify_hash = spotify_hash
    end

    session[:user_id] = user.id
    session[:spotify_hash] = spotify_hash
    redirect_to '/music'
  end

  def logout
     session[:user_id] = nil
     session[:spotify_hash] = nil
    redirect_to root_path
  end

  def failure
    render plain: 'this is a failure'
  end

  def show
    # get user and create RspotifyUser instance
    @user = RSpotify::User.new(session[:spotify_hash])

    # gets time from the global variable defined on front page
    time = $time.to_i
    if ($time)
      time = $time.to_i
   else
      # defaults to 1 hour if time was undefined
      time = 60
   end
    # get genre, default dubstep if not selected
    if ($genre)
      genre = $genre
    else
      genre = "dubstep"
    end
    # initialize variables for generating
    wanted_playlist_time_in_ms = time * 60000
    current_playlist_time = wanted_playlist_time_in_ms;
    result = RSpotify::Recommendations.generate(limit: 100, seed_genres: [genre])
    @playlist= @user.create_playlist!("your-chronotron-generated-playlist!")
    tracks = result.tracks
    your_playlist = []
    track_counter = 0
    current_track = tracks[track_counter]
    # loop that adds songs from recommendations to playlist
    while current_playlist_time > 0  && current_track do
      your_playlist.push(current_track)
      track_counter += 1
      current_playlist_time -= current_track.duration_ms
      current_track = tracks[track_counter]
    end
    # add final list of tracks to Spotify Playlist
    @playlist.add_tracks!(your_playlist)
  end

end
