class DropComments < ActiveRecord::Migration
  def up
    drop_table :comments
  end

  def down
    create_table :comments do |t|
      t.references :post, index: true, foreign_key: true
      t.text :body

      t.timestamps null: false
    end
  end
end
