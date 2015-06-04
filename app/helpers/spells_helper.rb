module SpellsHelper

  def spell_factory
    
    spell_base = ["Fireball","Iceshard","Boulder","Tornado"]

    
      spell_base.each do |spell|
          m = Spell.new
          m.name = spell
          m.attack = rand(2..3)
          m.damage = rand(9..20)
          m.speed = rand(1..3)
          m.defence = rand(6..8)

          case m.name
            when "Fireball"
              m.affinity = "fire"
            when "Iceshard"
              m.affinity = "water"
            when "Boulder"
              m.affinity = "earth"
              m.defence += 2
            when "Tornado"
              m.affinity  = "air"
          end

          m.save
      end
  

  end


end
