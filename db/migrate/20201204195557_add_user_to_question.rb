class AddUserToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_reference :questions, :user, null: false, unique: true, foreign_key: true
  end
end
