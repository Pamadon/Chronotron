class TrailController < ApplicationController
  def index
  end

  def show
    gon.choice = $choice
    hike_response = HTTParty.get "https://trailapi-trailapi.p.mashape.com/?limit=25&q[activities_activity_type_name_eq]=hiking&q[state_cont]=Washington&radius=25",
      headers:{
        "X-Mashape-Key" => "gKkZRWGHnsmsh9H4030c2YJirj8mp1co61Djsntmdy8iYTxtf7",
        "Accept" => "text/plain"
    }
  	$hikes = []
  	if hike_response.code == 200
      @hike_result = JSON.parse(hike_response.body)
      for place in @hike_result['places']
          $mode !='' ? place['mode'] = $mode : place['mode'] = 'driving'
          $location != '' ? place['origin'] = $location : place['origin'] = 'Seattle'
          $hikes.push(place)
      end
  	end
    puts '------------first hike from show----------------', $hikes[0]
  end

  def maps
    $hikes.size>10 ? @loops = 10 : @loops = $hikes.size
    for i in (0...@loops)
      map_response = HTTParty.get "https://maps.googleapis.com/maps/api/directions/json", {
        query: {
          origin: $hikes[i]['origin'],
          destination: $hikes[i]['lat'].to_s+","+$hikes[i]['lon'].to_s,
          mode: $hikes[i]['mode']
        }
      }
      @map = nil
      if map_response.code == 200 and map_response['status'] == "OK"
        @map = JSON.parse(map_response.body)
        @end_address = @map['routes'][0]['legs'][0]['end_address']
        @distance = @map['routes'][0]['legs'][0]['distance']
        @duration = @map['routes'][0]['legs'][0]['duration']
        $hikes[i]['end_address'] = @end_address
        $hikes[i]['distance'] = @distance
        $hikes[i]['duration'] = @duration
      end
      weather_response = HTTParty.get "http://api.openweathermap.org/data/2.5/weather", {
        query: {
          lat: $hikes[i]['lat'],
          lon: $hikes[i]['lon'],
          APPID: ENV['WEATHER_KEY']
        }
      }
      @weather = JSON.parse(weather_response.body)
      $hikes[i]['weather'] = ((9*(@weather['main']['temp']-273)/5)+32).round
    end
    puts '-----------first hike from maps---------', $hikes[0]
    render :partial => "maps"
  end
end
