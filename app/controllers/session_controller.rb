class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by :name => params[:username]
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id    #saves just the user id if [:user] holds all info!!! omg
      

      if !request.location.country_code == "RD"
        user.zipcode = request.location.zipcode
        user.state = request.location.region_name
        user.country = request.location.country_code
        user.save
      end

      Spell.all.each do |spell|

      user.spells << spell
      user.save

      end

      redirect_to root_path
    else
      flash[:notice] = "Invalid login, please try again"
      redirect_to login_path
    end

  end

  def destroy
    session[:user_id] = nil

    redirect_to root_path
  end

end
