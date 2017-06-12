class MusicController < ApplicationController
  def show

    @user = RSpotify::User.new(request.env['omniauth.auth'])
    # when we need to have genres available
    wanted_playlist_time_in_min = 30 * 60000
    # @genres = RSpotify::Recommendations.available_genre_seeds
    result = RSpotify::Recommendations.generate(limit: 20, seed_genres: ['dubstep'])
    tracks = result.tracks

    your_playlist=[]
    current_playlist_time = wanted_playlist_time_in_min;
    track_counter = 0

    while current_playlist_time > 0 do
      current_track = tracks[track_counter]
      your_playlist.push(current_track)
      track_counter += 1
      current_playlist_time -= current_track.duration_ms
      puts current_playlist_time
    end

    @playlist = your_playlist
  end


end
