class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :admin, :default => false
      t.string  :password_digest
      t.text :image, :default => "https://wiki.shibboleth.net/confluence/images/icons/profilepics/default.png"
      t.integer :deaths, :default => 0
      t.integer :highest_level, :default => 0
      t.integer :health, :default => 120
      t.integer :max_health, :default => 120
      t.float :longitude
      t.float :latitude
      t.string :zipcode
      t.string :country
      t.string :state
      t.integer :xp, :default => 0
      t.integer :gold, :default => 0
      t.integer :slota
      t.integer :slotb
      t.integer :level, :default => 1
      t.integer :pkills, :default => 0
      t.integer :dkills, :default => 0
      t.integer :mkills, :default => 0

      t.boolean :attackable, :default => false
      t.boolean :in_battle, :default => false
      t.integer :attacker_id

      t.timestamps


    end
  end
end
