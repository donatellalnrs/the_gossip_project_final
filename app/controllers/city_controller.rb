class CityController < ApplicationController
  def show
    @city = City.find(params[:id])

    i= 0
    @city.users.ids.length.times do |user|
    	@gossips = Gossip.where(user_id: @city.users.ids[i])
      i+= 1
    end 
  end
end
