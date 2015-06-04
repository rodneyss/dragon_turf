module PagesHelper

    ###########spawn some monsters at location###################
  def player_cords
        a= "http://vignette3.wikia.nocookie.net/monster/images/f/fc/Ogre.gif"
        b="http://www.beastsofwar.com/wp-content/uploads/2013/02/Ogre-Scheme-Green.jpg"
        c="http://3219a2.medialib.glogster.com/media/81/8124f3da8bdcdd1d332b9ddfd56f6fcae3dc15e229878adee44fbe3a4889c936/ogre-jpg-w300h356-png.png"
        s= "http://upload.wikimedia.org/wikipedia/en/9/97/True_Ogre.png"

        any_monsters = Monster.all.where :zipcode => @current_user.zipcode


        add_more = false

        if any_monsters.present? #more than 1km away will add more
            add_more = check_distance(any_monsters)
        end

        if any_monsters.empty?  || any_monsters.count < 2 || add_more
          6.times do
            cord1 = rand(0.00000..0.0081)
            cord2 = rand(0.00000..0.0081)

            m = Monster.new
            m.name = ["Toby","Drew","Connie","Fernando","Simon","Charles","Stella",
                     "Reena","Alan","Ben","Chris","Jack","Joel","Michael",
                     "Josh","Mark","Charlotte","Aaron","Andrew", "Rodney"].sample
            m.longitude = @current_user.longitude + cord1
            m.longitude = @current_user.longitude - cord1 if rand(2) == 0
            m.latitude = @current_user.latitude + cord2
            m.latitude = @current_user.latitude - cord2 if rand(2) == 0
            m.deaths = 0
            m.country = @current_user.country
            m.state = @current_user.state
            m.zipcode = @current_user.zipcode
            m.level = rand(1..10)
            m.gold = m.level*2
            m.xp = m.level*2
            m.attack = m.level*2
            m.damage = m.level*2
            m.speed = m.level*2
            m.defence = 10
            m.max_health = m.level*20
            m.health = m.level*20

            num = rand(1..100)
        
               
              if num > 90
                m.rank = "S"
                m.health += 40
                m.max_health = m.health
                m.damage += 15
                m.gold += 16
                m.name +=  m.level.to_s
                m.name += "S"
                m.defence += 3
                m.image = s
              elsif num > 80
                m.rank = "A"
                m.health += 30
                m.max_health = m.health
                m.damage += 8
                m.gold += 10
                m.name += m.level.to_s
                m.name += "A"
                m.defence += 2
                m.image = a
              elsif num > 70
                m.rank = "B"
                m.health += 20
                m.max_health = m.health
                m.damage += 5
                m.gold += 5
                m.name += m.level.to_s
                m.name += "B"
                m.defence += 1
                m.image = b
              else
                m.rank = "C"
                m.name += m.level.to_s
                m.name +="C"
                m.image = c
              end

            m.affinity = ["fire", "earth", "water", "air"].sample

            m.save
          end

        end
    end

def check_distance(mons)

    mons.each do |m|
     d = distance_between(@current_user.latitude, @current_user.longitude, m.latitude, m.longitude)

        if d < 1000
            return false
        end
    end

    return true

end


def distance_between(lat1, lon1, lat2, lon2)


  # convert degrees to radians

   lat1 = lat1/180 * Math::PI
   lon1 = lon1/180 * Math::PI
   lat2 = lat2/180 * Math::PI
   lon2 = lon2/180 * Math::PI

  # compute deltas
  dlat = lat2 - lat1
  dlon = lon2 - lon1

  a = (Math.sin(dlat / 2))**2 + Math.cos(lat1) * 
  (Math.sin(dlon / 2) ) **2 * Math.cos(lat2)
  c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))


  
  return (c * 6371000).round

  
end









end
