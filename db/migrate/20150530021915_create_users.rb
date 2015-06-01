class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :admin, :default => false
      t.string  :password_digest
      t.text :image
      t.integer :deaths
      t.integer :highest_level
      t.integer :health
      t.float :lng
      t.float :lat
      t.string :suburb
      t.string :country
      t.string :state
      t.integer :health
      t.integer :xp
      t.integer :gold
      t.integer :slota
      t.integer :slotb
      t.integer :level
      t.integer :pkills
      t.integer :dkills
      t.integer :mkills

      t.boolean :attackable, :default => false
      t.boolean :in_battle, :default => false
      t.integer :attacker_id

      t.timestamps

    end
  end
end
