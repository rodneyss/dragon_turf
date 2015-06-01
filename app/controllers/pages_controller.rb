class PagesController < ApplicationController
  include PagesHelper


    

  def home
  end

  def search
    ip_address = request.env['REMOTE_ADDR']
 

    player_cords()
    @any_monsters = Monster.all.where :suburb => @current_user.suburb

    gon.nearby_monsters = @any_monsters
  end

  def anymon
    c = params["my_data"].split(",")
    lng = c[0]
    lat = c[1]
    @current_user.lng = lng
    @current_user.lat = lat
    @current_user.save

    render :search
  end











end
