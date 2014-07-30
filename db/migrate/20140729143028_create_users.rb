class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :ooth_id
      t.string :ooth_source
      t.boolean :incognito
      t.text :bio
      t.string :permissions

      t.timestamps
    end
  end
end
