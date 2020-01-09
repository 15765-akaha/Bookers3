class ChangeNameColumnOnUser < ActiveRecord::Migration[5.2]
  def up
  	change_column_null :users, :name, false, 0
  	change_column :users, :name, :string, default: 0
  end

  def down
  	change_column_null :users, :name, true, nil
  	change_column :users, :name, :string, default: nil
  end
end
