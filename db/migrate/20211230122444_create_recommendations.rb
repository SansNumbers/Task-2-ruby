class CreateRecommendations < ActiveRecord::Migration[6.1]
  def change
    create_table :recommendations do |t|
      t.belongs_to :user
      t.belongs_to :coach
      t.belongs_to :technique

      t.integer :status
      t.integer :step
      
      t.timestamp :started_at
      t.timestamp :ended_at
      
      t.timestamps
    end
  end
end
