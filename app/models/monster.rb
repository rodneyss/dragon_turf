# == Schema Information
#
# Table name: monsters
#
#  id          :integer          not null, primary key
#  name        :string
#  image       :text
#  deaths      :integer
#  lng         :float
#  lat         :float
#  suburb      :string
#  country     :string
#  state       :string
#  xp          :integer
#  gold        :integer
#  level       :integer
#  rank        :string
#  attack      :integer
#  damage      :integer
#  speed       :integer
#  defence     :integer
#  affinity    :string
#  user_id     :integer
#  alive       :boolean          default(TRUE)
#  tagged      :boolean          default(FALSE)
#  attacker_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  zone_id     :integer
#

class Monster < ActiveRecord::Base
  belongs_to :user
  belongs_to :zone
end
