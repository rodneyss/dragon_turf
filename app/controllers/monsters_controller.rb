class MonstersController < ApplicationController
  include MonstersHelper

  def index
      @monsters = Monster.all
  end

  def attack

    @monster = Monster.find params[:id]
    
  end

  def damage

    @monster = Monster.find params[:monster_id]

      if @monster.attacker_id == @current_user.id || @monster.tagged == false
        @monster.attacker_id = @current_user.id
        @monster.tagged = true
        @monster.save

        gon.m_health = @monster.health
        gon.m_max_health = @monster.max_health
        gon.m_injury = @monster.injury
        # gon.spells = how_manyspells
        gon.p_health = @current_user.health
        gon.p_max_health = @current_user.max_health
        gon.p_injury = @current_user.injury
        gon.p_move = @current_user.move_first
        gon.winner = @current_user.winner

        @player_spells = how_manyspells



      end
  end


  def combat

  end


  def new
    @monster = Monster.new
  end

  def create
      @monster = Monster.new user_params
    if @monster.save
      redirect_to monsters_path
    end
  end

  def show
    @monster = Monster.find params[:id]
  end

  def edit
    @monster = Monster.find params[:id]
    render :new
  end

  def update
    monster = Monster.find params[:id]
    monster.update user_params
    redirect_to monster
  end

  def destroy
  monster = Monster.find params[:id]
  monster.destroy
  redirect_to monsters_path
  end


  private
  def user_params
    params.require(:monster).permit(:name, :attack, :damage, :defence, :rank, :xp, :gold, :level, :user_id, :rank, :affinity, :longitude, :latitude, :suburb, :state, :country, :alive, :tagged, :image, :speed, :health, :slota, :slotb, :monster_id)
  end
end
