class TrailController < ApplicationController
  def index
  end

  def show
    @length = params[:length]
    hike_response = HTTParty.get "https://trailapi-trailapi.p.mashape.com/?limit=25&q[activities_activity_type_name_eq]=hiking&q[state_cont]=Washington&radius=25",
      headers:{
        "X-Mashape-Key" => "gKkZRWGHnsmsh9H4030c2YJirj8mp1co61Djsntmdy8iYTxtf7",
        "Accept" => "text/plain"
    }
  	@hikes = []
  	if hike_response.code == 200
      @hike_result = JSON.parse(hike_response.body)
      for place in @hike_result['places']
        if place['activities'][0]['length'].to_i <= @length.to_i and place['activities'][0]['length'].to_i > 0
          map_response = HTTParty.get "https://maps.googleapis.com/maps/api/directions/json", {
            query: {
            origin: params[:origin],
            destination: place['lat'].to_s+","+place['lon'].to_s,
            mode: params[:mode]
            }
          }
          @maps = nil
          if map_response.code == 200
            @maps = JSON.parse(map_response.body)
            @end_address = @maps['routes'][0]['legs'][0]['end_address']
            @distance = @maps['routes'][0]['legs'][0]['distance']
            @duration = @maps['routes'][0]['legs'][0]['duration']
            place['end_address'] = @end_address
            place['distance'] = @distance
            place['duration'] = @duration
          end
          puts place
          @hikes.push(place)
        end
      end
  	end
		# puts response.body, response.code, response.message, response.headers.inspect
  end
end
