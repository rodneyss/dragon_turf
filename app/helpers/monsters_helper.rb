module MonstersHelper

  def factory
    m = Monster.new
    m.name = ["Bill","Marry","Joseph","Larry"].sample + (0...10).map { ('a'..'z').to_a[rand(26)] }.join
      m.deaths = 0
      m.country = "Australia"
      m.state = "NSW"
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
