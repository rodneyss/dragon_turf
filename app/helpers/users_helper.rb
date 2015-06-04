module UsersHelper


def user_winner
  @current_user.max_health += 10
  @current_user.health = @current_user.max_health 
  @current_user.level += 1
  @current_user.highest_level = @current_user.level if @current_user.level > @current_user.highest_level
  @current_user.injury = 0
  @current_user.in_battle = false
  @current_user.mkills +=1
  mon = Monster.find_by :attacker_id => @current_user.id
  @current_user.gold += mon.gold
  @current_user.save

  reset_monster
end


def user_looser
  @current_user.deaths +=1
  @current_user.health = 120
  @current_user.max_health = 120
  @current_user.injury = 0
  @current_user.level = 1
  @current_user.in_battle = false
  @current_user.gold = 0
  @current_user.save

  reset_monster
end


def reset_monster
  mon = Monster.find_by :attacker_id => @current_user.id
  mon.health = mon.max_health
  mon.attacker_id = nil
  mon.injury = 0
  mon.alive = true
  mon.tagged = false

  mon.save
end




end
