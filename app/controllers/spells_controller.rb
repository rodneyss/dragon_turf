class SpellsController < ApplicationController
  include SpellsHelper

  def index
      @spells = Spell.all
      spell_factory if @spells.empty?
  end


  def new
    @spell = Spell.new
  end

  def create
      @spell = Spell.new user_params
    if @spell.save
      redirect_to spells_path
    end
  end

  def show
    @spell = Spell.find params[:id]
  end

  def edit
    @spell = Spell.find params[:id]
    render :new
  end

  def update
    spell = Spell.find params[:id]
    spell.update user_params
    redirect_to spell
  end

  def destroy
  spell = Spell.find params[:id]
  spell.destroy
  redirect_to spells_path
  end


  private
  def user_params
    params.require(:spell).permit(:name, :attack, :dmg_type, :defence, :speed, :type, :affinity)
  end
end
