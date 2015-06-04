class MonstersController < ApplicationController
  include MonstersHelper
  include UsersHelper

  def index
      @monsters = Monster.all
  end

  def attack
    # if alive? go back to search
    @monster = Monster.find params[:id]
    
  end



  def damage


    if params[:monster_id]
      @monster = Monster.find params[:monster_id]
         @monster.attacker_id = @current_user.id
        @monster.tagged = true
        @monster.save
    
    else
     @monster = Monster.find_by :attacker_id => @current_user.id
    end

      if @monster.attacker_id == @current_user.id || @monster.tagged == false

          if @current_user.health <= 0 || @monster.alive == false
            
            redirect_to monster_result_path
          end

          @monster.attacker_id = @current_user.id
          @monster.tagged = true
          @monster.save
          gon.monster_id = @monster.id
          gon.m_health = @monster.health
          gon.m_max_health = @monster.max_health
          gon.m_injury = @monster.injury
          gon.p_health = @current_user.health
          gon.p_max_health = @current_user.max_health
          gon.p_injury = @current_user.injury
          gon.p_move = @current_user.move_first
          gon.winner = @current_user.winner
          gon.battle = @current_user.in_battle

          @player_spells = how_manyspells

      end
  end


  def combat

    atk =0
    dmg =0
    defence =0
    spd =0
    
    @current_user.in_battle = true
    @current_user.save


    if params[:slota].present? || params[:slotb].present?


         spellboxes = []

         m = Spellbox.find_by :user_id => @current_user.id, :spell_id => params[:slota]  
         spellboxes << m if m.present?
         m = Spellbox.find_by :user_id => @current_user.id, :spell_id => params[:slotb]
         spellboxes << m if m.present?

         spellboxes.each do |box|
            if box.amount >= 1
                box.amount += -1
                box.save
                spell_stat = Spell.find box.spell_id
                atk += spell_stat.attack
                dmg += spell_stat.damage
                defence += spell_stat.defence
                spd += spell_stat.speed

                if box.amount <=0
                  box.destroy
                end
            end

         end
    end

    stats = []

    if atk != 0
     stats << atk << dmg << defence<<spd
    end


    
     monster = Monster.find params[:monster_id]

     blow_exchange(stats, monster)

     redirect_to :controller => 'monsters', :action => 'damage'
     
  end




  def result

      if @current_user.in_battle 
          if @current_user.health <= 0
            @result = "You Loose..try harder"
            user_looser
          else
            @result = "You WIN!"
            user_winner
          end
      end

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
    params.require(:monster).permit(:name, :attack, :damage, :defence, :rank, :xp, :gold, :level, :user_id, :rank, :affinity, :longitude, :latitude, :suburb, :state, :country, :alive, :tagged, :image, :speed, :health, :slota, :slotb, :monster_id, :max_health)
  end
end
