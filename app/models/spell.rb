# == Schema Information
#
# Table name: spells
#
#  id         :integer          not null, primary key
#  name       :string
#  attack     :integer
#  damage     :integer
#  defence    :integer
#  dmg_type   :string
#  speed      :integer
#  affinity   :string
#  created_at :datetime
#  updated_at :datetime
#

class Spell < ActiveRecord::Base
  has_many :spellboxes
  has_many :users, :through => :spellboxes

end
