class Spellbox < ActiveRecord::Migration
  def change
    create_table :spellboxes do |t|
    t.belongs_to :spell, index: true
    t.belongs_to :user, index: true
    t.integer :amount
    end
  end
end
