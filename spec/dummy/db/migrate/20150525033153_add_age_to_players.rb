class AddAgeToPlayers < ActiveRecord::Migration
  def change
  	add_column :players, :age, :integer
  end
end
