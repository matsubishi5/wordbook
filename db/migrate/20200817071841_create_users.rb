class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, default: "", null: false, unique: true
      t.string :password, default: "", null: false
      t.integer :highest_rate, default: 0

      t.timestamps
    end
  end
end
