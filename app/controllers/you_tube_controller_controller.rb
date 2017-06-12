class YouTubeControllerController < ApplicationController
require 'google/api_client'
require 'trollop'
  def index
  end

  def show
	response = HTTParty.get('https://www.googleapis.com/youtube/v3/search?part=snippet&q=french+lessons&key=AIzaSyB9vzAQ4Nn-Ig3fzaRdDEO0zptnI85vPSM')

	puts response.body, response.code, response.message, response.headers.inspect

 # 	response = HTTParty.get("https://www.googleapis.com/youtube/v3/search?part=snippet&q=lady+-gaga&key=AIzaSyB9vzAQ4Nn-Ig3fzaRdDEO0zptnI85vPSM'", {
	# 	query: {term: params['search']['query']}
	# })
	# 	@data = nil
	# 	if response.code == 200
	# 		@data = JSON.parse(response.body)
 #  end
end
  def search
  end

	def get_service
  client = Google::APIClient.new(
    :key => ENV['DEVELOPER_KEY'],
    :authorization => nil,
    :application_name => $PROGRAM_NAME,
    :application_version => '1.0.0'
  )
  youtube = client.discovered_api(ENV['YOUTUBE_API_SERVICE_NAME'], ENV['YOUTUBE_API_VERSION'])

  return client, youtube
end

def main
  opts = Trollop::options do
    opt :q, 'Search term', :type => String, :default => 'Google'
    opt :max_results, 'Max results', :type => :int, :default => 25
  end

  client, youtube = get_service

  begin
    # Call the search.list method to retrieve results matching the specified
    # query term.
    search_response = client.execute!(
      :api_method => youtube.search.list,
      :parameters => {
        :part => 'snippet',
        :q => opts[:q],
        :maxResults => opts[:max_results]
      }
    )

    videos = []
    channels = []
    playlists = []

    # Add each result to the appropriate list, and then display the lists of
    # matching videos, channels, and playlists.
    search_response.data.items.each do |search_result|
      case search_result.id.kind
        when 'youtube#video'
          videos << "#{search_result.snippet.title} (#{search_result.id.videoId})"
        when 'youtube#channel'
          channels << "#{search_result.snippet.title} (#{search_result.id.channelId})"
        when 'youtube#playlist'
          playlists << "#{search_result.snippet.title} (#{search_result.id.playlistId})"
      end
    end

    puts "Videos:\n", videos, "\n"
    puts "Channels:\n", channels, "\n"
    puts "Playlists:\n", playlists, "\n"
  rescue Google::APIClient::TransmissionError => e
    puts e.result.body
  end
end
end
