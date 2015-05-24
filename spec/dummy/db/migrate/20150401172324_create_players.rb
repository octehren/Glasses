class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :country
      t.string :ip_address
      t.datetime :first_win
      t.datetime :first_defeat
      t.boolean :is_virgin
      t.integer :age
      t.timestamps null: false
    end
  end
end
