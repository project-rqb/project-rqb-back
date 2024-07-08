class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.integer :uid, null: false
      t.string :provider, null: false
      t.string :github_uid, null: false
      t.string :name
      t.integer :term_id
      t.text :profile

      t.timestamps
    end
    add_index :users, :uid, unique: true
  end
end
