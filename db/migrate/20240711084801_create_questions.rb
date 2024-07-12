class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :uuid, null: false
      t.string :title, null: false, limit: 150
      t.text :body, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :questions, :uuid, unique: true
  end
end
