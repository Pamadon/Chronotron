class MusicController < ApplicationController
    before_action :current_user

  def spotify
    @user = RSpotify::User.new(request.env['omniauth.auth'])
    spotify_hash = @user.to_hash
    puts "music time"
    puts $time
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
    @user = RSpotify::User.new(session[:spotify_hash])
    # when we need to have genres available
    time = $time.to_i
    wanted_playlist_time_in_ms = time * 60000
    # @genres = RSpotify::Recommendations.available_genre_seeds
    result = RSpotify::Recommendations.generate(limit: 20, seed_genres: ['dubstep'])
    tracks = result.tracks

    @playlist= @user.create_playlist!("your-chronotron-generated-playlist!")
    current_playlist_time = wanted_playlist_time_in_ms;
    track_counter = 0
    your_playlist = []


    while current_playlist_time > 0 do
      current_track = tracks[track_counter]
      your_playlist.push(current_track)
      track_counter += 1
      current_playlist_time -= current_track.duration_ms
    end

    @playlist.add_tracks!(your_playlist)
  end
end
