class CreateProblems < ActiveRecord::Migration[6.1]
  def change
    create_table :problems do |t|
      t.string :title

      t.timestamps
    end

    create_table :user_problem, id: false do |t|
      t.belongs_to :user
      t.belongs_to :problem
    end

    create_table :coach_problem, id: false do |t|
      t.belongs_to :coach
      t.belongs_to :problem
    end

    create_table :technique_problem, id: false do |t|
      t.belongs_to :technique
      t.belongs_to :problem
    end
  end
end