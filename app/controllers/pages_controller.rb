class PagesController < ApplicationController
  include PagesHelper

  def home
  end

  def search
  
      gon.nearby_monsters = Monster.all.where :zipcode => @current_user.zipcode
  
  end

  def anymon
    c = params["my_data"].split(",")
    lat = c[0].to_f
    lng = c[1].to_f
    @current_user.latitude = lat
    @current_user.longitude = lng
    
    
    info = Geocoder.search([lat, lng]).first
    @current_user.zipcode = info.postal_code
    @current_user.state = info.state_code
    @current_user.country = info.country_code

    @current_user.save

    zip = Zone.find_by :name => @current_user.zipcode

    if zip.present?
      zip_code = Zone.new
      zip_code.name = @current_user.zipcode
      zip_code.save
    end

    player_cords()

    @any_monsters = Monster.all.where :zipcode => @current_user.zipcode
      gon.nearby_monsters = @any_monsters

    
  end











end
