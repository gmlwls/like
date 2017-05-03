class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.text :comment
      t.string :username

      t.timestamps null: false
    end
  end
end
