class ChangeIsNameDefaultOnUsers < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :users, :name, from:"0", to: ""
  end
end
