class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :question, null: false, foreign_key: true, index: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
