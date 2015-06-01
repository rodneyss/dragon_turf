module PagesHelper


  def player_cords


    any_monsters = Monster.all.where :suburb => @current_user.suburb


    if any_monsters == nil  || any_monsters.count < 2
      6.times do
        cord1= rand(0.00000..0.0081)
        cord2= rand(0.00000..0.0081)

        m = Monster.new
        m.name = ["Bill","Marry","Joseph","Larry"].sample + (0...10).map { ('a'..'z').to_a[rand(26)] }.join

        m.lng = @current_user.lng + cord1
        m.lng = @current_user.lng - cord1 if rand(2) == 0
        m.lat = @current_user.lat + cord2
        m.lat = @current_user.lat - cord2 if rand(2) == 0
        m.deaths = 0
        m.country = @current_user.country
        m.state = @current_user.state
        m.suburb = @current_user.suburb
        m.level = rand(1..10)
        m.gold = m.level*2
        m.xp = m.level*2
        m.rank = "C"
        m.attack = m.level*2
        m.damage = m.level*2
        m.speed = m.level*2
        m.defence = m.level*2
        m.affinity = "fire"

        m.save
      end


    end

  end







end
