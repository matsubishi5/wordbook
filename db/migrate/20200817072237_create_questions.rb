class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :question, default: "", null: false, unique: true
      t.text :description, default: "", null: false

      t.timestamps
    end
  end
end
