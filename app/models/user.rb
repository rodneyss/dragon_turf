# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  admin           :boolean          default(FALSE)
#  password_digest :string
#  image           :text
#  deaths          :integer
#  highest_level   :integer
#  health          :integer
#  lng             :float
#  lat             :float
#  suburb          :string
#  country         :string
#  state           :string
#  xp              :integer
#  gold            :integer
#  slota           :integer
#  slotb           :integer
#  level           :integer
#  pkills          :integer
#  dkills          :integer
#  mkills          :integer
#  attackable      :boolean          default(FALSE)
#  in_battle       :boolean          default(FALSE)
#  attacker_id     :integer
#  created_at      :datetime
#  updated_at      :datetime



#

class User < ActiveRecord::Base
  
  has_secure_password


  validates :name, :presence => true
  validates :name, :uniqueness => true
  
  has_many :spellboxes
  has_many :spells, :through => :spellboxes
  has_many :monsters

  
end
