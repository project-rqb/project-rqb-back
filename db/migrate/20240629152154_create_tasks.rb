class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name, null: false, limit: 10
      t.text :description, limit: 100
      t.timestamps
    end
  end
end
