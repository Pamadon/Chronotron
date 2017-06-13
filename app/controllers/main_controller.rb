class MainController < ApplicationController
    def index
      $time = params[:time_limit]
      puts "root time"
      puts $time
    end

end
