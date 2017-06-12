class TrailController < ApplicationController
  def index
  end

  # def maps
  #   @hike_distance = 'async get'
  #   puts 'in maps ctrl!!!!!!!!!!!!!!!!!!!!!!!'
  #   puts 'hike 1', $hikes[0]
  #   render :partial =>"maps"
  # end

  def show
    @length = params[:length]
    hike_response = HTTParty.get "https://trailapi-trailapi.p.mashape.com/?limit=25&q[activities_activity_type_name_eq]=hiking&q[state_cont]=Washington&radius=25",
      headers:{
        "X-Mashape-Key" => "gKkZRWGHnsmsh9H4030c2YJirj8mp1co61Djsntmdy8iYTxtf7",
        "Accept" => "text/plain"
    }
  	$hikes = []
  	if hike_response.code == 200
      @hike_result = JSON.parse(hike_response.body)
      for place in @hike_result['places']
        if place['activities'][0]['length'].to_i <= @length.to_i and place['activities'][0]['length'].to_i > 0
          place['mode'] = params[:mode]
          place['origin'] = params[:origin]
          $hikes.push(place)
        end
      end
  	end
		# puts response.body, response.code, response.message, response.headers.inspect
  end

  def maps
    puts 'in maps ctrl'
    puts 'hikes length', $hikes.length
    puts 'hikes size', $hikes.size
    @loop = $hikes.size-2
    for i in (0...10)
      puts 'i', i
      map_response = HTTParty.get "https://maps.googleapis.com/maps/api/directions/json", {
          query: {
          origin: $hikes[i]['origin'],
          destination: $hikes[i]['lat'].to_s+","+$hikes[i]['lon'].to_s,
          mode: $hikes[i]['mode']
          }
        }
        @map = nil
        if map_response.code == 200
          @map = JSON.parse(map_response.body)
          # puts @map
          @end_address = @map['routes'][0]['legs'][0]['end_address']
          @distance = @map['routes'][0]['legs'][0]['distance']
          @duration = @map['routes'][0]['legs'][0]['duration']
          $hikes[i]['end_address'] = @end_address
          $hikes[i]['distance'] = @distance
          $hikes[i]['duration'] = @duration
        end
    end
    render :partial => "maps"
  end
end
