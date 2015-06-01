module SpellsHelper

  def factory
    m = Spell.new
    m.name = ["Fireball","Iceshard","Magic Missiles","Tornado"].sample

      m.attack = rand(1..3)
      m.damage = rand(5..10)
      m.speed = rand(1..3)
      m.defence = rand(1..4)
      m.affinity = "fire"

  m.save


  end


  b = Spellbox.new
  b.user_id = 1
  b.spell_id = 1
  b.save



end
