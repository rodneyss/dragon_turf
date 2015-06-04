module MonstersHelper

  def how_manyspells
    spell_cache = []

      @current_user.spells.all.each do |s|
        spell = s.name 
        spell = Spellbox.find_by :spell_id => s.id, :user_id => @current_user.id

          spell.amount.times do
            m = Spell.find s.id
            spell_cache << m
          end

      end
    spell_cache

  end


  def blow_exchange(stats, monster)
    atk = 0
   
    if stats.present?

        if stats.last >= monster.speed 
          @current_user.move_first = true
        else
          @current_user.move_first = false
        end

        atk = rand(20) + stats.first
        atk = atk >= 20 ? 20 : atk
        if atk >= monster.defence
             monster.injury = ( stats.second )
             monster.health += -monster.injury
        else
            monster.injury = 0
        end

        atk = rand(20) + monster.attack
        atk = atk >= 20 ? 20 : atk
        if atk >= stats.third
            @current_user.injury = monster.damage
            @current_user.health += -monster.damage
        else
          @current_user.injury = 0
        end


        if monster.health <= 0
          monster.alive = false
          monster.deaths +=1
        end

        if @current_user.health <= 0
          @current_user.deaths += 1
        end

    else #if you attack with no spells you die
      @current_user.health = 0
      @current_user.injury = @current_user.max_health
      monster.injury = 0
    end



    @current_user.save
    monster.save

  end   


  

end
