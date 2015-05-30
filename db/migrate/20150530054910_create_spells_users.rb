class CreateSpellsUsers < ActiveRecord::Migration
  def change
    create_table :spells_users, :id => false do |t|
      t.integer :spell_id
      t.integer :user_id
    end
  end
end
