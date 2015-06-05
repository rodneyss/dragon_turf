class SessionController < ApplicationController
  include UsersHelper
  include PagesHelper

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
        player_cords #spawn some monsters
        user.save
      end

      if Spell.count > 0

          Spell.all.each do |spell|
            stash = Spellbox.find_by :user_id => user.id, :spell_id => spell.id
            if stash.present?
                stash.amount += 1
                stash.save
            else
              user.spells << spell
              user.save
            end

          end
      end




        if user.health <=0
          user_looser
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
