class ParentId < ActiveRecord::Migration
  def change
    rename_column :statements, :parent, :parent_id
  end
end
