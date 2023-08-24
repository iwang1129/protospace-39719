class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :user_id
      t.integer :prototype_id
      t.references :prototype, null: false, foreign_key: true 
      t.references :user, null: false, foreign_key: true 
      t.timestamps
    end
  end
end
