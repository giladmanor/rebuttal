class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.string :title
      t.text :body
      t.references :user, index: true
      t.integer :upvotes
      t.integer :downvotes
      t.integer :rank
      t.integer :parent
      t.boolean :draft

      t.timestamps
    end
  end
end
