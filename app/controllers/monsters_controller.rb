class MonstersController < ApplicationController
  def index
      @monsters = Monster.all
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
    params.require(:monster).permit(:name, :attack, :damage, :defence, :rank, :xp, :gold, :level, :user_id, :rank, :affinity, :lng, :lat, :suburb, :state, :country, :alive, :tagged, :image, :speed)
  end
end
