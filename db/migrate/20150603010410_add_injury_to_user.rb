class AddInjuryToUser < ActiveRecord::Migration
  def change
    add_column :users, :injury, :integer, :default => 0
  end
end
