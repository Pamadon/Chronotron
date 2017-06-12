class MusicController < ApplicationController

  def spotify
    @user = RSpotify::User.new(request.env['omniauth.auth'])
    hash = spotify_user.to_hash
  end

  def show

    @user = RSpotify::User.new(request.env['omniauth.auth'])
    # when we need to have genres available
    wanted_playlist_time_in_ms = 30 * 60000
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
      puts current_playlist_time
    end

    @playlist.add_tracks!(your_playlist)
  end




end
