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

end
