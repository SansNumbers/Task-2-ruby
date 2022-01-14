class AddResponsesCount < ActiveRecord::Migration[6.1]
  def change
    add_column :coaches, :responses_count, :integer

    add_column :recommendations, :responses_count, :integer

    add_column :problems, :responses_count, :integer

    add_column :invitations, :responses_count, :integer

    add_column :techniques, :responses_count, :integer
  end
end
