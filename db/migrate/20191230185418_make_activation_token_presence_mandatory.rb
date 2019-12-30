class MakeActivationTokenPresenceMandatory < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :activation_token, false
  end
end
