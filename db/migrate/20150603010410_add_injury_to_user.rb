class AddInjuryToUser < ActiveRecord::Migration
  def change
    add_column :users, :injury, :integer
  end
end
