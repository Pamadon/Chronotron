class MusicController < ApplicationController
  def show
    @test = RSpotify::Recommendations.generate(seed_genres: ['blues', 'country'])
  end
end
