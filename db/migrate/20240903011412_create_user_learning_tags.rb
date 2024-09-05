class CreateUserLearningTags < ActiveRecord::Migration[7.1]
  def change
    create_table :user_learning_tags do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
    end

    add_index :user_learning_tags, %i[user_id tag_id], unique: true
  end
end
