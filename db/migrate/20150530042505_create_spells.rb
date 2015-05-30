class CreateSpells < ActiveRecord::Migration
  def change
    create_table :spells do |t|
      t.string :name
      t.integer :attack
      t.integer :damage
      t.integer :defence
      t.string :dmg_type
      t.integer :speed
      t.string :affinity

      t.timestamps
    end
  end
end
