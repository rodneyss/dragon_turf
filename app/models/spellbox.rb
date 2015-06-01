# == Schema Information
#
# Table name: spellboxes
#
#  id       :integer          not null, primary key
#  user_id  :integer
#  spell_id :integer
#  amount   :integer
#

class Spellbox < ActiveRecord::Base
  belongs_to :user
  belongs_to :spell

end
