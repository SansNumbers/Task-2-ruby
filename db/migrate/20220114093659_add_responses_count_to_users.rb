class AddResponsesCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :responses_count, :integer
  end
end
