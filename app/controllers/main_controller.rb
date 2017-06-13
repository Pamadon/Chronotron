class MainController < ApplicationController
    def index
      $time = params[:time_limit]
      $genre = params[:genre]
      puts "root time"
      puts $time, $genre
    end

end
