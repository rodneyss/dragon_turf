class CreateMonsters < ActiveRecord::Migration
  def change
    create_table :monsters do |t|
      t.string :name
      t.text :image
      t.integer :deaths
      t.float :lng
      t.float :lat
      t.string :suburb
      t.string :country
      t.string :state
      t.integer :xp
      t.integer :gold
      t.integer :level
      t.integer :health
      t.string :rank
      t.integer :attack
      t.integer :damage
      t.integer :speed
      t.integer :defence
      t.string :affinity
      t.integer :user_id

      t.boolean :alive, :default => true
      t.boolean :tagged, :default => false
      t.integer :attacker_id

      t.timestamps
    end
  end
end
